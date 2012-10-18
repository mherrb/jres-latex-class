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
% This work consists of the files jres-resume.cls and resume.tex
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jres-resume}[2012/10/04 v1.0
 JRES resume document class]
%
\LoadClass[12pt]{article}
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
  \setmainfont[Mapping=tex-text]{Liberation Serif}
  \setsansfont[Mapping=tex-text]{Liberation Sans}
  \setmonofont[Mapping=tex-text]{Liberation Mono}
\else
  \ifluatex
    \RequirePackage{fontspec}
    \setmainfont{Liberation Serif}
    \setsansfont{Liberation Sans}
    \setmonofont{Liberation Mono}
  \else
    \ClassWarningNoLine{jres}{%
    Utilisez de préférence xelatex pour formatter le document}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \RequirePackage{helvet}
    \renewcommand{\familydefault}{\sfdefault}
  \fi
\fi
\RequirePackage{sectsty}
%
% Règles typographiques Françaises...
\RequirePackage[french]{babel}
%
% Papier A5
\setlength\paperheight{210mm}
\setlength\paperwidth{148mm}
\RequirePackage[top=1cm,bottom=1cm,left=1cm,right=1cm]{geometry}
%
% liste des auteurs
\RequirePackage{datatool}
\DTLnewdb{auteurs}
\newcommand{\auteur}[2]{%
\DTLnewrow{auteurs}%
\DTLnewdbentry{auteurs}{nom}{#1}%
\DTLnewdbentry{auteurs}{affiliation}{#2}%
}
% Presentation titre
\def\@maketitle{%
  \newpage
  \begin{center}%
  \let \footnote \thanks
    {\large\sffamily\bfseries \@title \par}%
  \end{center}
  \begin{flushleft}
    \vskip 5mm%
    \DTLforeach{auteurs}{%
      \@nom=nom,\@affi=affiliation}{%
    {\noindent\normalsize \@nom\newline}%
    {\small \@affi \par}}
  \end{flushleft}%
  \vskip 1ex%
}
%
\renewenvironment{abstract}{%
        \noindent
        \thispagestyle{empty}%
        {\sffamily\textbf{Résumé}}\par}{\par}
\newcommand{\motscles}[1]{%
        \noindent%
        {\sffamily\textbf{Mots clefs}}\par#1\vskip 1ex}

\setlength{\parindent}{0cm}
\setlength{\parskip}{1ex plus 0.5ex minus 0.2ex}
%
% Configuration de listings
\RequirePackage{color}
\RequirePackage{listings}
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
% Pas de small caps pour Figure ou Tableau
\AtBeginDocument{\def\figurename{Figure}}
\AtBeginDocument{\def\tablename{Tableau}}
%
