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
\ProvidesClass{jres}[2012/10/04 v1.0
 JRES document class]
%
\LoadClass{article}
%
% Polices...
% XeTeX ou LuaTeX permettent facilement de choisir Liberation Sans Narrow
% Donc on essaye de forcer la main à l'utilisateur pour qu'il l'utilise..
%
% D'abord il faut trouve ifxetex.sty ou l'emuler
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
% c'est parti pour la config 
\ifxetex
  \RequirePackage{fontspec}
  \setmainfont[Mapping=tex-text]{Times New Roman}
  \setsansfont[Mapping=tex-text]{Helvetica}
  \setmonofont[Mapping=tex-text]{Courier New}
\else
  \ifluatex
    \RequirePackage{fontspec}
    \setmainfont{Times New Roman}
     \setsansfont{Helvetica}
     \setmonofont{Courier New}
  \else
    \ClassWarningNoLine{jres}{%
    Utilisez de préférence xelatex pour formatter le document}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage{times}
  \fi
\fi
%
% Règles typographiques Françaises...
\RequirePackage[french]{babel}
%
% Papier A4
\setlength\paperheight{297mm}
\setlength\paperwidth{210mm}
\RequirePackage[top=2.5cm,bottom=3cm,left=2cm,right=2cm]{geometry}
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
    {\LARGE\bfseries \@title \par}%
  \end{center}
  \begin{flushleft}
    \vskip 10mm%
    \DTLforeach{auteurs}{%
      \@nom=nom,\@affi=affiliation,\@adr=adresse}{%
    {\noindent\large \@nom\par}%
    {\normalsize \@affi \par}
    {\normalsize \@adr\par}\vskip 3mm}
  \end{flushleft}%
  \vskip 3mm%
  \par
}

% Redefinition de \date pour garder une valeur pour le footer
\def\date#1{\gdef\@date{#1}\gdef\@jresdate{#1}}

%
\renewenvironment{abstract}{%
        \noindent
        \thispagestyle{fancy}%
        {\sffamily\textbf{Résumé}}\par\begin{itshape}}{\end{itshape}\par}
\newcommand{\motscles}[1]{%
        \vskip 2ex
        \noindent%
        {\sffamily\textbf{Mots clefs}}\par\begin{itshape}#1\end{itshape}}

\setlength{\parindent}{0cm}
\setlength{\parskip}{1ex plus 0.5ex minus 0.2ex}

%%%----------------------------------------------------------------------
%%%
%%% Les headers "speciaux" (necessite fancyheadings.sty)
%%%
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\lfoot{\@jresdate}
\cfoot{\thepage/\pageref{LastPage}}
\rfoot{JRES 2013}
\pagestyle{fancy}

%
% Configuration de listings
\RequirePackage{color}
\RequirePackage{listings}
\definecolor{grey80}{rgb}{.8,.8,.8}
\lstset{backgroundcolor=\color{grey80}}
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
% Pas de small caps pour Figure ou Tableau
\AtBeginDocument{\def\figurename{Figure}}
\AtBeginDocument{\def\tablename{Tableau}}
%
% Bibliographie
\AtBeginDocument{\def\refname{Bibliographie}}
\bibliographystyle{jres}


% TODO
% Style narrow pour pdflatex (?)

