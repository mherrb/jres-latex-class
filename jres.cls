%% Copyright 2012 CNRS LAAS
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Matthieu Herrb
%
% This work consists of the files jres.cls and article.tex
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jres}[2012/10/18 v1.0
 JRES document class]
% Derive de la classe article
\LoadClass{article}
%
% Options
\RequirePackage{kvoptions}
\DeclareStringOption[2013]{year}
\ProcessKeyvalOptions*
%
% Le nom de la conf
\def\@jresconf{JRES~\jres@year}
%
%
% Polices...
% XeTeX ou LuaTeX permettent facilement de choisir les polices système
% Donc on essaye de forcer la main à l'utilisateur pour qu'il l'utilise..
%
% D'abord il faut trouve ifxetex.sty ou l'émuler
\newif\ifm@mifxetex
  \m@mifxetexfalse
\IfFileExists{ifxetex.sty}{\RequirePackage{ifxetex}}{%
  \ClassWarningNoLine{jres}{%
    The `ifxetex' package is not installed.\MessageBreak
    The package is being emulated}%
\expandafter\newif\csname ifxetex\endcsname
\@ifundefined{XeTeXrevision}{\xetexfalse}{\xetextrue}
\m@mifxetextrue%
}
\newif\ifm@mifluatex
  \m@mifluatexfalse
\IfFileExists{ifluatex.sty}{\RequirePackage{ifluatex}}{%
  \ClassWarningNoLine{jres}{%
    The `ifluatex' pagckage is not installed.\MessageBreak
    The package is being emulated}%
\expandafter\newif\csname ifluatex\endcsname
\@ifundefined{luatexversion}{\luatexfalse}{\luatextrue}
\m@mifluatextrue%
}
% configuration des fontes proprement dite
\ifxetex
  % avec xetex c'est le mieux, le mapping tex-text permet de faire les césures
  \RequirePackage{fontspec}
  \setmainfont[Mapping=tex-text]{Times New Roman}
  \setsansfont[Mapping=tex-text]{Arial}
  \setmonofont[Mapping=tex-text]{Courier New}
\else
  \ifluatex
    \RequirePackage{fontspec}
    % luatex ne supporte pas encore le mapping tex-text
    \setmainfont{Times New Roman}
    \setsansfont{Arial}
    \setmonofont{Courier New}
  \else
    % si c'est pdflatex qui est utilisé, on revient aux paquets PSNFSS existants
    \ClassWarningNoLine{jres}{%
    Utilisez de préférence xelatex ou lualatex pour formatter le document}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage{times}
  \fi
\fi
% Titres en sans-serif + couleur
\RequirePackage{color}
\definecolor{jresblue}{rgb}{0.,0.2,0.375} % correspond a 0,32,96 du modele word
\RequirePackage{sectsty}
\allsectionsfont{\sffamily\scshape\color{jresblue}}
%
% Règles typographiques Françaises...
\ifxetex
  \RequirePackage{polyglossia}
  \setdefaultlanguage{french}
\else
\RequirePackage[french]{babel}
\fi
%
% Papier A4
\setlength\paperheight{297mm}
\setlength\paperwidth{210mm}
% Marges
\RequirePackage[top=2cm,bottom=2cm,left=3cm,right=3cm]{geometry}
%
% liste des auteurs
\RequirePackage{datatool}
\DTLnewdb{auteurs}
\newcommand{\auteur}[3]{%
\DTLnewrow{auteurs}%
\DTLnewdbentry{auteurs}{nom}{#1}%
\DTLnewdbentry{auteurs}{affiliation}{#2}%
\DTLnewdbentry{auteurs}{adresse}{#3}%
}
% Presentation titre
\def\@maketitle{%
  \newpage
  \begin{center}%
  \let \footnote \thanks
    {\LARGE\bfseries\sffamily\color{jresblue} \@title \par}%
  \end{center}
  \begin{flushleft}
    \vskip 10mm%
    \DTLforeach{auteurs}{%
      \@nom=nom,\@affi=affiliation,\@adr=adresse}{%
    {\noindent\sffamily\scshape\large\color{jresblue} \@nom\\}%
    {\normalsize\sffamily \@affi \\}
    {\normalsize\sffamily \@adr\par}\vskip 3mm}
  \end{flushleft}%
  \vskip 3mm%
  \par
}

% Redefinition de \date pour garder une valeur pour le footer
\def\date#1{\gdef\@date{#1}\gdef\@jresdate{#1}}
\def\title#1{\gdef\@title{#1}\gdef\@jrestitle{#1}}
\date{Montpellier -- 10 au 13 D\'ecembre}
%
\renewenvironment{abstract}{%
        \noindent
        {\sffamily\scshape\color{jresblue}\textbf{Résumé}}\par\begin{itshape}}{\end{itshape}\par}
\newcommand{\motscles}[1]{%
        \vskip 2ex
        \noindent%
        {\sffamily\scshape\color{jresblue}\textbf{Mots clefs}}\par\begin{itshape}#1\end{itshape}}

\setlength{\parindent}{0cm}
\setlength{\parskip}{1ex plus 0.5ex minus 0.2ex}
%
% Les entêtes et pieds de page
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
% pour la 1ere page
\fancypagestyle{plain}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0.1pt}
  \lfoot{\@jresdate}
  \cfoot{\thepage/\pageref{LastPage}}
  \rfoot{\@jresconf}
}
% les autres pages
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0.1pt}
%\chead{\@jrestitle}
\lfoot{\@jresdate}
\cfoot{\thepage/\pageref{LastPage}}
\rfoot{\@jresconf}
\pagestyle{fancy}
%
% Configuration de listings
\RequirePackage{listings}
\definecolor{grey80}{rgb}{.8,.8,.8}
\definecolor{grey90}{rgb}{.9,.9,.9}
\lstset{backgroundcolor=\color{grey90}}
\lstset{basicstyle=\small\ttfamily}
\newenvironment{codesource}%
        {\begin{lstlisting}}%
        {\end{lstlisting}\vskip 1ex}
%
% style urls
\RequirePackage{url}
\urlstyle{same}
\DeclareUrlCommand\url{\color{blue}}
%
% Figures
\RequirePackage{graphicx}
% Titre en italique...
\long\def\@caption#1[#2]#3{%
  \par
  \addcontentsline{\csname ext@#1\endcsname}{#1}%
    {\protect\numberline{\csname the#1\endcsname}{\ignorespaces #2}}%
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \normalsize
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces \itshape #3}\par
  \endgroup}
% Pas de small caps pour les labels de Figure ou Tableau
\AtBeginDocument{\def\figurename{Figure}}
\AtBeginDocument{\def\tablename{Tableau}}
%
% Bibliographie
\AtBeginDocument{\def\refname{Bibliographie}}
\bibliographystyle{jres}
