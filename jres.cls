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
% This work consists of the files jres.cls and paper.tex
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jres}[2012/10/04 v1.0
 JRES document class]
%
\LoadClass{article}
%
% Polices...
% XeTeX permet facilement de choisir Liberation Sans Narrow
% Donc on essaye de forcer la main à l'utilisateur pour qu'il l'utilise..
%
% D'abord il faut trouve ifxetex.sty ou l'emuler
\newif\ifm@mifxetex
  \m@mifxetexfalse
\IfFileExists{ifxetex.sty}{\RequirePackage{ifxetex}\relax}{%
  \ClassWarningNoLine{memoir}{%
    The `ifxetex' package is not installed.\MessageBreak
    The package is being emulated}%
\expandafter\newif\csname ifxetex\endcsname
\@ifundefined{XeTeXrevision}{\xetexfalse}{\xetextrue}
\m@mifxetextrue%
%%\EmulatedPackage{ifxetex}[2008/07/23]
}
\ifm@mifxetex%
\def\RequireXeTeX{%
  \ifxetex\else
  \ClassError{jres}{XeTeX is required to process this document}%
            {Try again with xelatex, not (pdf)latex.\MessageBreak
             Or try removing any XeTeX package(s).}
  \fi}
\fi
% c'est parti pour la config 
\ifxetex
  \RequirePackage{fontspec}
  \setmainfont[Mapping=tex-text]{Liberation Sans Narrow}
\else
  \ClassWarningNoLine{jres}{%
    Utilisez de préférence xelatex pour formatter le document}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[T1]{fontenc}
  \RequirePackage{helvet}
  \renewcommand{\familydefault}{\sfdefault}
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
%
\renewenvironment{abstract}{%
        \noindent
        \textbf{Résumé}\par\begin{itshape}}{\end{itshape}\par}
\newcommand{\motscles}[1]{%
        \vskip 2ex
        \noindent%
        \textbf{Mots clefs}\par\begin{itshape}#1\end{itshape}}

\setlength{\parindent}{0cm}
\setlength{\parskip}{1ex plus 0.5ex minus 0.2ex}
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

% TODO
% Biblio
% Style narrow pour pdflatex (?)
% Pied de page
