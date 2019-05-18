%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%
%%%%%%%%	Clase U-Memoria
%%%%%%%%	Autor: Nikolas Tapia M.
%%%%%%%%	Version: 1.3
%%%%%%%%	Fecha: 21-06-2012
%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[2009/09/24]
\ProvidesClass{aFormat/uMemoria_Spanish}[2012/06/18 v1.2 Clase LaTeX para estandarizacion de Memorias U. de Chile]

%% Definicion de Condicionales
\newif\if@swapnum
\newif\if@contnum
\@swapnumfalse
\@contnumtrue

%% Declaracion de Opciones
\DeclareOption{leftnum}{\@swapnumtrue}
\DeclareOption{rightnum}{\@swapnumfalse}
\DeclareOption{contnum}{\@contnumtrue}
\DeclareOption{nocontnum}{\@contnumfalse}
\DeclareOption{uprightd}{\AtEndOfPackage{\DeclareMathSymbol{d}{\mathalpha}{operators}{`d}}}
\DeclareOption{uprighte}{\AtEndOfPackage{\DeclareMathSymbol{e}{\mathalpha}{operators}{`e}}}
\DeclareOption{uprighti}{\AtEndOfPackage{\DeclareMathSymbol{i}{\mathalpha}{operators}{`i}}}
\DeclareOption{upright}{\ExecuteOptions{uprightd,uprighte,uprighti}}

%% Pasar Opciones a clase Book
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[12pt, openany]{book}

%% Packages necesarios
\RequirePackage[top=2cm, left=3cm, bottom=2cm, right=2cm, paper=letterpaper]{geometry}	%%Margenes
\RequirePackage{amsmath, amssymb, amsthm, graphicx}										%%Varios
%\RequirePackage[english, es-nolists, es-lcroman]{babel}									%%Lenguaje
\RequirePackage[english]{babel}									%%Lenguaje
\RequirePackage[pdfpagelabels]{hyperref}												%%Links y numeracion del PDF

%% Lenguaje
\addto\captionsspanish{\renewcommand\tablename{Tabla}}
\addto\captionsspanish{\renewcommand\listtablename{\'Indice de tablas}}

%% Interlineado
\RequirePackage{parskip}
\setlength{\parskip}{1em}
\setlength{\parindent}{15pt}

%% Renovar enumerate e itemize
\let\oldenum\enumerate
\let\oldendenum\endenumerate
\renewenvironment{enumerate}{\oldenum\setlength{\parskip}{\smallskipamount}}{\oldendenum}
\let\olditem\itemize
\let\oldenditem\enditemize
\renewenvironment{itemize}{\olditem\setlength{\parskip}{\smallskipamount}}{\oldenditem}

%% Entornos nuevos
\newenvironment{abstract}{\cleardoublepage\chapter*{Resumen}}{\vfill\null}
\newenvironment{dedicatoria}{\cleardoublepage\null\vspace{\stretch{1}}\begin{flushright}\itshape}{\end{flushright}\vspace{\stretch{2}}\null}
\let\thanks\undefined
\newenvironment{thanks}{\chapter*{Agradecimientos}}{\vfill\null}
\newenvironment{intro}{\addcontentsline{toc}{chapter}{\protect\numberline{}Introducci\'on}\chapter*{Introducci\'on}}{\vfill\null}
\newenvironment{conclusion}{\addcontentsline{toc}{chapter}{\protect\numberline{}Conclusi\'on}\chapter*{Conclusi\'on}}{\vfill\null}






% ******************************* Nomenclature *********************************
\RequirePackage[intoc]{nomencl}
\makenomenclature
\renewcommand{\nomgroup}[1]{%
\ifthenelse{\equal{#1}{A}}{\item[\textbf{Roman Symbols}]}{%
\ifthenelse{\equal{#1}{G}}{\item[\textbf{Greek Symbols}]}{%
\ifthenelse{\equal{#1}{Z}}{\item[\textbf{Acronyms / Abbreviations}]}{%
\ifthenelse{\equal{#1}{R}}{\item[\textbf{Superscripts}]}{%
\ifthenelse{\equal{#1}{S}}{\item[\textbf{Subscripts}]}{%
\ifthenelse{\equal{#1}{X}}{\item[\textbf{Other Symbols}]}
{}
}% matches mathematical symbols > X
}% matches Subscripts           > S
}% matches Superscripts         > R
}% matches Abbreviations        > Z
}% matches Greek Symbols        > G
}% matches Roman Symbols        > A

% To add nomenclature in the header
%\renewcommand{\nompreamble}{\markboth{\nomname}{\nomname}}

% Add nomenclature to contents and print out nomenclature
\newcommand{\printnomencl}[1][]{
\ifthenelse{\equal {#1}{}}
{\printnomenclature}
{\printnomenclature[#1]}
%\addcontentsline{toc}{chapter}{\nomname}
}


%% Teoremas, proofs, etc
\renewenvironment{proof}[1][\proofname] {\par\pushQED{\qed}\normalfont\topsep6\p@\@plus6\p@\relax\trivlist\item[\hskip\labelsep\scshape\footnotesize#1\@addpunct{.}]\ignorespaces}{\popQED\endtrivlist\@endpefalse}

\newtheoremstyle{miestilo}{\baselineskip}{3pt}{\itshape}{}{\bfseries}{}{.5em}{}
\newtheoremstyle{miobs}{\baselineskip}{3pt}{}{}{\bfseries}{}{.5em}{}
\if@swapnum
	\swapnumbers
\fi
\theoremstyle{miestilo}
\newtheorem{defn}{Definici\'on}[chapter]
\if@contnum
\newtheorem{teo}[defn]{Teorema}
\newtheorem{cor}[defn]{Corolario}
\newtheorem{lema}[defn]{Lema}
\newtheorem{prop}[defn]{Proposici\'on}
\else
\newtheorem{teo}{Teorema}[chapter]
\newtheorem{cor}{Corolario}[chapter]
\newtheorem{lema}{Lema}[chapter]
\newtheorem{prop}{Proposici\'on}[chapter]
\fi
\theoremstyle{miobs}
\newtheorem*{ej}{Ejemplo}
\newtheorem*{obs}{Observaci\'on}

%% Comandos para la portada
\global\let\@carrera\@empty
\newcommand{\setcarrera}[1]{\def\@carrera{#1}}
\let\carrera\setcarrera
\let\setcarrera\relax

\global\let\@memoria\@empty
\newcommand{\setmemoria}[1]{\def\@memoria{#1}}
\let\memoria\setmemoria
\let\setmemoria\relax

\global\let\@guia\@empty
\newcommand{\setguia}[1]{\def\@guia{#1}}
\let\guia\setguia
\let\setguia\relax

\global\let\@depto\@empty
\newcommand{\setdepto}[1]{\def\@depto{#1}}
\let\depto\setdepto
\let\setdepto\relax

\global\let\@comisa\@empty
\global\let\@comisb\@empty
\global\let\@comisc\@empty
\newcommand{\comision}[3]{
	\def\@comisa{#1}
	\def\@comisb{#2}
	\def\@comisc{#3}
}

\global\let\@auspicio\@empty
\newcommand{\setauspicio}[1]{\def\@auspicio{#1}}
\let\auspicio\setauspicio
\let\setauspicio\relax

%%Portada
\renewcommand{\maketitle}{
	\begin{titlepage}
		\begin{minipage}{1.6cm}
			\includegraphics[scale=.12]{Figures/UChile/escudoU.pdf}
		\end{minipage}
		\begin{minipage}[t]{12cm}
			UNIVERSIDAD DE CHILE\\FACULTAD DE CIENCIAS F\'ISICAS Y MATEM\'ATICAS\\\MakeUppercase\@depto
		\end{minipage}

		\vspace{2cm}
		\centering
			\MakeUppercase\@title

		\vspace{1cm}
			\@memoria \MakeUppercase\ \@carrera

		\vspace{1cm}
			\MakeUppercase\@author

		\vspace{3cm}
			PROFESOR GU\'IA:\\ \MakeUppercase\@guia

		\vspace{1cm}
			MIEMBROS DE LA COMISI\'ON:\\ \MakeUppercase\@comisa\\\MakeUppercase\@comisb\\\MakeUppercase\@comisc
		\if\@auspicio\@empty\else

		\vfill
			\normalfont
			Este trabajo ha sido parcialmente financiado por \@auspicio
		\fi

		\vfill
			SANTIAGO DE CHILE\\ \MakeUppercase\@date
	\end{titlepage}
}

%%Estilo del frontmatter
\newcommand{\ps@front}{
	\renewcommand{\thepage}{\roman{page}}
	\renewcommand{\@oddhead}{}
	\renewcommand{\@evenhead}{}
	\renewcommand{\@oddfoot}{\hfill\thepage\hfill}
	\renewcommand{\@evenfoot}{\hfill\thepage\hfill}
}

\let\oldfrontmatter\frontmatter
\renewcommand{\frontmatter}{
	\pagestyle{front}
	\oldfrontmatter
}
\let\oldfrontmatter\relax

%% Miscelaneos
\newcommand{\A}{\mathcal{A}}
\newcommand{\C}{\mathbb{C}}
\newcommand{\D}{\mathbb{D}}
\newcommand{\E}{\mathbb{E}}
\newcommand{\F}{\mathcal{F}}
\newcommand{\G}{\mathcal{G}}
\renewcommand{\H}{\mathcal{H}}
\newcommand{\K}{\mathcal{K}}
\renewcommand{\L}{\mathcal{L}}
\newcommand{\M}{\mathcal{M}}
\newcommand{\N}{\mathbb{N}}
\renewcommand{\M}{\mathcal{M}}
\renewcommand{\P}{\mathbb{P}}
\newcommand{\Q}{\mathbb{Q}}
\newcommand{\R}{\mathbb{R}}
\renewcommand{\S}{\mathcal{S}}
\newcommand{\T}{\mathcal{T}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\1}{\mathbf{1}}
\let\epsilon\varepsilon
