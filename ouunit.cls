\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ouunit}[2016/05/1 1.24 (Robert Hasson, all rights reserved)]

%switch for draft mode
\newif\ifdraft
\drafttrue

%switch to determine papersize
\newif\if@reduced
\@reducedfalse

%switch to decide whether solutions and comments are set in place or at the end
\newif\if@tend
\@tendfalse

%switch for two column solutions
\newif\if@twocolsol
\@twocolsolfalse

%switch to remove author and editor comments
\newif\if@nocomments
\@nocommentsfalse

%switch to remove author and editor comments
\newif\if@standalone
\@standalonefalse

\DeclareOption{final}{\draftfalse}
\DeclareOption{reduceda4}{\@reducedtrue}
\DeclareOption{solutionsatend}{\@tendtrue}
\DeclareOption{twocolumnsolutions}{\@twocolsoltrue}
\DeclareOption{nocomments}{\@nocommentstrue}
\DeclareOption{standalone}{\@standalonetrue}

%\ExecuteOptions{}

\ProcessOptions\relax
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load packages/class file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{fix-cm}%load first before any fonts are used

%add to global options to make equations flush left
\RequirePackage{etoolbox}
\if@standalone
\preto\@classoptionslist{fleqn,11pt,}
\LoadClass[fleqn,11pt]{article}
\else
\preto\@classoptionslist{fleqn,11pt,twoside,}
\LoadClass[fleqn,11pt,twoside]{article}
\fi


\RequirePackage{xcolor}
\if@reduced
\RequirePackage[papersize={210mm,263mm},text={30pc,54pc},marginpar=12pc,marginparsep=1pc,bindingoffset=-2cm,columnsep=12bp]{geometry}%
\else
\if@standalone
\RequirePackage[a4paper,text={30pc,61pc},marginpar=12pc,marginparsep=1pc,bindingoffset=-4cm,columnsep=12bp]{geometry}%
\else
\RequirePackage[a4paper,text={30pc,61pc},marginpar=12pc,marginparsep=1pc,bindingoffset=-2cm,columnsep=12bp]{geometry}%
\fi
\fi
\RequirePackage{fancyhdr}
\RequirePackage{calc}
\RequirePackage{graphicx}
\RequirePackage{ifthen}
\RequirePackage{tikz}
\RequirePackage{array}
\RequirePackage[fleqn]{amsmath}
\RequirePackage{amssymb}
\RequirePackage[inline,shortlabels]{enumitem}
\RequirePackage{marginnote}
\RequirePackage{environ}
\RequirePackage[nobottomtitles*]{titlesec}
\RequirePackage{framed}
\RequirePackage{datetime}
\RequirePackage{fancyvrb}
\RequirePackage{float}
\RequirePackage[amsmath,thmmarks]{ntheorem}
\RequirePackage{adjmulticol}% includes standard multicol style
\RequirePackage{colortbl}
\RequirePackage[totoc]{idxlayout}
\RequirePackage{fullwidth}



%if final then remove comments
\ifdraft\relax\else\@nocommentstrue\fi

%page style defaults
\raggedright
\raggedbottom 
\hyphenpenalty=10000
\setlength{\mathindent}{20pt}
\setlength{\leftmargin}{24pt}
\setlength{\parindent}{0pt}
\setlength{\parskip}{1ex plus 0.1ex minus 0.1ex}
\setlength{\topsep}{0.5ex plus 0.05ex minus 0.05ex}
\setlength{\partopsep}{0ex}
\setlength{\itemsep}{0.5ex plus 0.05ex minus 0.05ex}
\setlength{\jot}{0.5ex plus 0.05ex minus 0.05ex}% separation of equations in align


%spacing around displayed math
%could also adjust skips for \small and \footnotesize 
\g@addto@macro\normalsize{%could be \appto
\setlength{\abovedisplayskip}{0.5ex plus 0.05ex minus 0.05ex}%
\setlength{\belowdisplayskip}{0.5ex plus 0.05ex minus 0.05ex}%
\setlength{\abovedisplayshortskip}{0.5ex plus 0.05ex minus 0.05ex}%
\setlength{\belowdisplayshortskip}{0.5ex plus 0.05ex minus 0.05ex}}

%metadata
\def\@faculty{Faculty of Science, Technology, Engineering and Mathematics}
\DeclareRobustCommand\faculty[1]{\DeclareRobustCommand\@faculty{#1}}

\DeclareRobustCommand\modulecode[1]{\renewcommand\@modulecode{#1}}
\DeclareRobustCommand\@modulecode{\@latex@error{No \noexpand\modulecode specified}\@ehc}

\DeclareRobustCommand\moduletitle[1]{\renewcommand\@moduletitle{#1}}
\DeclareRobustCommand\@moduletitle{\@latex@error{No \noexpand\moduletitle specified}\@ehc}

\DeclareRobustCommand\@unitid{}
\DeclareRobustCommand{\unitid}[1]{\gdef\@unitid{#1}\gdef\@title{Unit \@unitid\quad \@unittitle}}

\global\let\@title\@empty
\global\let\@unittitle\@empty
\DeclareRobustCommand{\unittitle}[1]{\gdef\@unittitle{#1}\gdef\@title{Unit \@unitid\quad \@unittitle}}%global defs are needed for even header in books

\global\let\@draftno\@empty
\DeclareRobustCommand{\draftno}[1]{\DeclareRobustCommand\@draftno{#1}}

\global\let\@copyrightyear\@empty
\newcommand\copyrightyear[1]{\def\@copyrightyear{#1}}

\ifdraft
\def\@suppno{DRAFT}
\else
\global\let\@suppno\@empty
\fi
\newcommand\suppno[1]{\DeclareRobustCommand\@suppno{#1}}
\global\let\@versionno\@empty
\newcommand\versionno[1]{\DeclareRobustCommand\@versionno{#1}}

\DeclareRobustCommand{\itemid}[1]{}

\DeclareRobustCommand{\uniqueID}[1]{}

\global\let\@author\@empty

% Title page
\ifpdf%change order to preferentially include pdf logo
\DeclareGraphicsExtensions{.pdf,.png,.jpg,.eps}
\fi

%Draft logo placeholder
%redefine \oulogo to use official logo, e.g. 
%\DeclareRobustCommand{\oulogo}{\includegraphics[width=3.5cm]{ou_cmyk_masterlogo_29mm}}
%or
% \DeclareRobustCommand{\oulogo}{\includegraphics[width=3.5cm]{OU_Master_Logo_Blue_CMYK_29mm}}
\DeclareRobustCommand{\oulogo}{\tikz{\path[fill=colourThree] (0.1,1) [rounded corners=2mm] -- ++(0,1.4) -- ++(2.05,0) [rounded corners=0mm] -- ++(0,-1.4) arc (0:-180:1.025) --cycle;\path[fill=white] (0.9,1.65) circle (0.45);\draw (1.25,1.1) node[white,rotate=45] {\Huge \sf Draft};}}


\DeclareRobustCommand{\maketitle}{
\begin{adjmulticols}{1}{-1cm}{-1cm}
\hfuzz=100pt%do not report overfull hbox for title header
\begin{tabular}{@{}p{35mm}@{\qquad}p{13cm}}
\vtop{\null\hbox{\oulogo}}
&
\vspace*{0mm}\raggedright
\textbf{\@faculty}\par
\textbf{\@modulecode~\@moduletitle}\par
\bigskip\hrule
\bigskip\bigskip\textbf{\LARGE \@title}\par
\bigskip\bigskip\hrule
\ifdraft
\medskip
\emph{\rule{0pt}{3ex}\large Draft \ifx\@empty\@draftno\@empty \else\@draftno\ \fi prepared for the module team\ifx\@empty\@author\@empty \else\ by \@author\fi.}
\fi
\end{tabular}
\end{adjmulticols}
\thispagestyle{firstpage}}

\DeclareRobustCommand{\makefrontpages}{\maketitle\tableofcontents\thispagestyle{firstpage}\newpage}


%colours
\colorlet{colourOne}{black}    % colour 1 is main text colour
\colorlet{colourOneTint}{colourOne!20}          % 20% tint
\definecolor{colourTwo}{cmyk}{0.87,0,.38,0}     % Pantone 326C
\colorlet{colourTwoTint}{colourTwo!20}          % 20% tint
\definecolor{colourThree}{cmyk}{1,0.45,0,0.14}  % Pantone 2945C
\colorlet{colourThreeTint}{colourThree!20}      % 20% tint
\definecolor{colourFour}{cmyk}{0,0.53,1,0.04}   % Pantone 7413C
\colorlet{colourFourTint}{colourFour!20}        % 20% tint


%fonts
\def\ssnormalsize{\fontsize{12.5pt}{15pt}\selectfont}
\def\reducedsize{\fontsize{10.5pt}{12.6pt}\selectfont}

\def\defaultheadfont{\usefont{OT1}{cmss}{bx}{n}}
\def\superitemlabelfont{\defaultheadfont\ssnormalsize}
\def\fighdfont{\defaultheadfont\reducedsize}
\def\figcaptfont{\normalfont\reducedsize}
\def\tablehdfont{\defaultheadfont\small}
\def\tablecaptfont{\normalfont\small}
\def\titledboxheadfont{\defaultheadfont\ssnormalsize}
\def\runningheadstyle{\defaultheadfont\normalsize\color{colourThree}}
\def\marginnotestyle{\raggedright\normalfont\small\color{black}\setlength{\mathindent}{0pt}\renewcommand{\baselinestretch}{1}}


%  Boxes 

%set space surrounding frame
\setlength{\OuterFrameSep}{\medskipamount}

\newcommand{\roundedboxbottom}[3]{\setbox0\vbox{#3}\tikz[overlay]{\path[fill=#1] (-4mm,{\ht0+4mm})  -- ++({\wd0+8mm},0) [rounded corners=#2]  -- ++(0,{-\ht0-8mm})  -- ++({-\wd0-8mm},0) [rounded corners=0mm] --  cycle;}\rule[-\dp0-4mm]{0pt}{\dp0+\ht0+8mm}\box0}

\newenvironment{roundedbox}[1][colourFour]{% open (top or bottom) framed
  \def\FrameCommand{\roundedboxbottom{#1Tint}{4mm}}%
  \def\FirstFrameCommand{\roundedboxbottom{#1Tint}{0mm}}%
  \def\MidFrameCommand{\roundedboxbottom{#1Tint}{0mm}}%
  \def\LastFrameCommand{\roundedboxbottom{#1Tint}{4mm}}%
  \MakeFramed {\advance\hsize-8mm\FrameRestore}%
  }{\endMakeFramed}

\newenvironment{roundedtitledbox}[2][colourFour]{\begin{roundedbox}[#1]\setbox0\hbox{\mbox{\titledboxheadfont\color{#1} #2}}\ifdim\wd0=\z@\relax\else\box0\nopagebreak\@afterheading\par\fi}{\end{roundedbox}}

\newenvironment{style1box}[1][]{\begin{roundedtitledbox}[colourThree]{#1}}{\end{roundedtitledbox}}

\newenvironment{style2box}[1][]{\begin{roundedtitledbox}[colourTwo]{#1}}{\end{roundedtitledbox}}
 
\newenvironment{style4box}[1][]{\begin{roundedtitledbox}[colourFour]{#1}}{\end{roundedtitledbox}}

\newcommand{\semiopenbox}[2]{\setbox0\vbox{#2}%
\tikz[overlay]{\draw[color=#1] (-4mm,{\ht0+4mm})  -- ++({\wd0+8mm},0)  -- ++(0,{-\ht0-8mm})  -- ++({-\wd0-8mm},0) --  cycle;}\rule[-\dp0-4mm]{0pt}{\dp0+\ht0+8mm}\box0}

\newenvironment{colourframed}[1][colourTwo]{
  \def\FrameCommand{\semiopenbox{#1}}%
  \def\FirstFrameCommand{\semiopenbox{#1}}%
  \def\MidFrameCommand{\semiopenbox{#1}}%
  \def\LastFrameCommand{\semiopenbox{#1}}%
  \MakeFramed{\advance\hsize-8mm\FrameRestore}%
  }{\endMakeFramed}

\newenvironment{style3box}[1][]{\begin{colourframed}
\setbox0\hbox{\mbox{\titledboxheadfont\color{colourTwo} #1}}\ifdim\wd0=\z@\relax\else\box0\nopagebreak\@afterheading\par\fi}{\end{colourframed}}

\newcommand{\leftrulebox}[2]{\setbox0\vbox{#2}{\color{#1}\rule[-\dp0-4mm]{2.5mm}{\dp0+\ht0+8mm}}\hspace*{1.5mm}\box0}

\newenvironment{leftrule}[1][colourTwo]{
  \def\FrameCommand{\leftrulebox{#1}}%
  \def\FirstFrameCommand{\leftrulebox{#1}}%
  \def\MidFrameCommand{\leftrulebox{#1}}%
  \def\LastFrameCommand{\leftrulebox{#1}}%
  \MakeFramed{\advance\hsize-8mm\FrameRestore}%
  }{\endMakeFramed}

%online style for style4box
\newenvironment{onlinestyle4box}[1][]{\begin{leftrule}
\setbox0\hbox{\mbox{\titledboxheadfont\color{colourTwo} #1}}\ifdim\wd0=\z@\relax\else\box0\nopagebreak\@afterheading\par\fi}{\end{leftrule}}

%section titles
%header for numbered sections
\newcommand{\@ddheadern}[1]{#1\xdef\rightmark{\thesection{\unexpanded{\quad #1}}}}

%header for unnumbered sections
\newcommand{\@ddheaderu}[1]{#1\gdef\rightmark{#1}%
\stepcounter{section}\addtocounter{section}{-1}%to force numberwithin counters to reset
}

\titleformat{\section}{\filright\defaultheadfont\huge\color{colourThree}}{\thesection}{1em}{\@ddheadern}
\titleformat{name=\section,numberless}{\filright\defaultheadfont\huge\color{colourThree}}{}{0pt}{\@ddheaderu}
\titleformat{\subsection}{\filright\defaultheadfont\LARGE\color{colourTwo}}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\filright\defaultheadfont\Large\color{colourTwo}}{\thesubsubsection}{1em}{}
\titleformat{\paragraph}{\filright\defaultheadfont\large\color{colourTwo}}{\theparagraph}{1em}{}
\titlespacing*{\section}{0pt}{2ex plus 1ex minus .2ex}{0.5ex plus .2ex}
\titlespacing*{\subsection}{0pt}{1.5ex plus 1ex minus .2ex}{0ex plus .2ex}
\titlespacing*{\subsubsection}{0pt}{1ex plus 1ex minus .2ex}{0ex plus .2ex}
\titlespacing*{\paragraph}{0pt}{1ex plus 1ex minus .2ex}{0ex plus .2ex}


\newcommand{\introduction}{\section*{Introduction}\addcontentsline{toc}{section}{Introduction}}


%index items
\makeindex
\def\printindex{\newpage\if@reduced
\newgeometry{text={42pc,54pc},marginpar=0pt,marginparsep=1pc,twoside}%
\else
\newgeometry{text={42pc,61pc},marginpar=0pt,marginparsep=1pc,twoside}%
\fi
\pagestyle{fancy}%
\fancyhfoffset[LE]{0pt}%
\fancyhfoffset[RO]{0pt}%
\fancyhead[LE,RO]{\runningheadstyle\rightmark}
\input{\jobname.ind}}
\newcommand*{\see}[2]{\emph{see} #1}
\newcommand*{\seealso}[2]{\emph{see also} #1}


%headers and footers
%\pagestyle{fancy}
\fancypagestyle{plain}{\fancyhf{}
\if@standalone
\fancyhead[R]{\runningheadstyle\rightmark}
\fancyfoot[R]{\runningheadstyle\thepage}
\ifdraft
\fancyfoot[L]{\raisebox{-2ex}{\small Draft \@draftno\quad Last \LaTeX ed  \currenttime\ \today}}
\fi
\else
\fancyhfoffset[LE]{\marginparsep+\marginparwidth}
\fancyhfoffset[RO]{\marginparsep+\marginparwidth}
\fancyhead[LE]{\runningheadstyle\@title}
\fancyhead[RO]{\runningheadstyle\rightmark}
\fancyfoot[LE,RO]{\runningheadstyle\thepage}
\ifdraft
\fancyfoot[LO,RE]{\raisebox{-2ex}{\small Draft \@draftno\quad Last \LaTeX ed  \currenttime\ \today}}
\fi
\fi
\renewcommand{\headrulewidth}{0pt}%
\markboth{\@title}{\rightmark}%
\setlength{\voffset}{10pt}%
\setlength{\headsep}{15pt}%
\setlength{\footskip}{25pt}%
\setlength{\headheight}{20pt}}
\pagestyle{plain}

\if@standalone
\fancypagestyle{firstpage}{\fancyhf{}%
\fancyfoot[L]{\large\textbf{Copyright \copyright\ \@copyrightyear\ The Open University}\hfill \textbf{\@suppno}\\\textbf{\@versionno}}%
\renewcommand{\headrulewidth}{0pt}%
\renewcommand{\footrulewidth}{2pt}%
}
\else
\fancypagestyle{firstpage}{\fancyhf{}}
\fi



%solutions
\newwrite\exercises@write
\AtBeginDocument{\immediate\openout\exercises@write\jobname.ex} 
\newwrite\activities@write
\AtBeginDocument{\immediate\openout\activities@write\jobname.act} 

%This works for a single solution (without a heading)
%\newenvironment{solution}{\VerbatimEnvironment\begin{VerbatimOut}{\jobname.ex}}{\end{VerbatimOut}}

\newif\if@activity%determines whether mv@solution writes to .ex or .act
\@activityfalse

%modified VerbatimOut from fancyvrb to not close file
\def\mv@solution{\FV@Environment{}{solution}}
\def\FVB@mv@solution{\@bsphack
  \begingroup
    \FV@UseKeyValues
    \FV@DefineWhiteSpace
    \def\FV@Space{\space}%
    \FV@DefineTabOut
\if@activity
    \immediate\write\activities@write{\string\subsubsection*{Solution to \activityname\space \theactivity}}
    \def\FV@ProcessLine{\immediate\write\activities@write}%
\else
    \immediate\write\exercises@write{\string\subsubsection*{Solution to \exercisename\space \theexercise}}
    \def\FV@ProcessLine{\immediate\write\exercises@write}%
\fi
    \let\FV@FontScanPrep\relax
%% DG/SR modification begin - May. 18, 1998 (to avoid problems with ligatures)
    \let\@noligs\relax
%% DG/SR modification end
    \FV@Scan}
\def\FVE@mv@solution{\endgroup\@esphack}
\DefineVerbatimEnvironment{solution}{mv@solution}{}

\newcounter{solnequation}
\def\thesolnequation{S\arabic{solnequation}}
\newcounter{solnfigure}
\def\thesolnfigure{S\arabic{solnfigure}}

%common setup for solutions (in-place and at-end)
\newcommand{\solutions@tup}{%
\let\c@equation\c@solnequation
\let\theequation\thesolnequation
\let\c@figure\c@solnfigure
\let\thefigure\thesolnfigure}

%marker box for two column solutions
\newcommand{\s@lutioncolumnbox}[1]{\setbox0\vbox{#1}\tikz[overlay]{\draw[line width=\columnsep,color=blue!5] ({0.5\textwidth+0.5\marginparwidth},0) -- ++(0,{\ht0});}\box0}

\newenvironment{s@lutioncolumn}{%
  \def\FrameCommand{\s@lutioncolumnbox}%
  \def\FirstFrameCommand{\s@lutioncolumnbox}%
  \def\MidFrameCommand{\s@lutioncolumnbox}%
  \def\LastFrameCommand{\s@lutioncolumnbox}%
  \MakeFramed{\setlength{\hsize}{0.5\textwidth+0.5\marginparwidth-0.5\columnsep}\FrameRestore}%
  }{\endMakeFramed}

%define the format of solutions in place
\if@twocolsol
\newenvironment{ip@solution}{\par\addvspace{\medskipamount}%
\begin{s@lutioncolumn}%
\mbox{\superitemlabelfont\color{colourThree}Solution}%
\nopagebreak\par\nopagebreak\addvspace{\medskipamount}\@afterheading%
\setlist[enumerate]{align=left,leftmargin=0pt,labelindent=0pt,labelwidth=!,itemindent=2em,font=\textbf}%
\solutions@tup}{\par\unskip\end{s@lutioncolumn}}
\else
\newenvironment{ip@solution}{\par\addvspace{\medskipamount}%
\mbox{\superitemlabelfont\color{colourThree}Solution}%
\nopagebreak\par\nopagebreak\addvspace{\medskipamount}\@afterheading%
\solutions@tup}{}
\fi

%format of exercise solutions at end
\newcommand{\exercisesolutionhead}{Solutions to exercises}
\newcommand{\printexercisesolutions}{\if@tend
      \immediate\closeout\exercises@write
\newpage\addcontentsline{toc}{section}{\exercisesolutionhead}\if@twocolsol\begin{adjmulticols}{1}{0pt}{-\marginparwidth}
\section*{\exercisesolutionhead}\end{adjmulticols}\else\section*{\exercisesolutionhead}\fi
\if@twocolsol\begin{adjmulticols*}{2}{0pt}{-\marginparwidth}%
\setlist[enumerate]{align=left,leftmargin=0pt,labelindent=0pt,labelwidth=!,itemindent=2em,font=\textbf}%
\raggedcolumns\fi
\solutions@tup
\input{\jobname.ex}
\if@twocolsol\end{adjmulticols*}\fi
\fi}



%format of activity solutions at end
\newcommand{\activitysolutionhead}{Solutions to activities}
\newcommand{\printactivitysolutions}{\if@tend
      \immediate\closeout\activities@write
\newpage\addcontentsline{toc}{section}{\activitysolutionhead}\if@twocolsol\begin{adjmulticols}{1}{0pt}{-\marginparwidth}
\section*{\activitysolutionhead}\end{adjmulticols}\else\section*{\activitysolutionhead}\fi
\if@twocolsol\begin{adjmulticols*}{2}{0pt}{-\marginparwidth}%
\setlist[enumerate]{align=left,leftmargin=0pt,labelindent=0pt,labelwidth=!,itemindent=2em,font=\textbf}%
\raggedcolumns\fi%
\solutions@tup
\input{\jobname.act}
\if@twocolsol\end{adjmulticols*}\fi
\fi}

%switch to solutions in place
\newcommand{\solutionsinplace}{\@tendfalse
\def\solution{}%so that renew is always appropriate
\renewenvironment{solution}{\begin{ip@solution}}{\end{ip@solution}}
}

%switch to solutions at end
\newcommand{\solutionsatend}{\@tendtrue\DefineVerbatimEnvironment{solution}{mv@solution}{}}

%now setup the default
\if@tend\solutionsatend\else\solutionsinplace\fi


%Exercises
\newif\if@ndrule
\@ndruletrue
\newcommand{\noendrule}{\@bsphack\@ndrulefalse\@esphack}

\newcounter{exercise}
\newcommand{\exercisename}{Exercise}
\newenvironment{exercisestyle}[2]{\pagebreak[3]\par\addvspace{\medskipamount}%
{\superitemlabelfont\color{colourTwo}\medskip
\hrule\nopagebreak
\rule[-.1\baselineskip]{0pt}{1.1\baselineskip}\twoparttitle{#1\quad}{#2}}%
\nopagebreak\par\nopagebreak\addvspace{\smallskipamount}\@afterheading
}{\par\addvspace{\medskipamount}\if@ndrule\nopagebreak\@afterheading\par
  {\color{colourTwo}\hrule}\fi\pagebreak[3]\par\addvspace{\medskipamount}}

\newenvironment{exercise}[1][]{\refstepcounter{exercise}\begin{exercisestyle}{\exercisename~\theexercise}{#1}}{\end{exercisestyle}}


%Activities
\newcounter{activity}
\newcommand{\activityname}{Activity}
\newenvironment{activitystyle}[2]{\pagebreak[3]\par\addvspace{\medskipamount}%
\fboxsep 0.5em\colorbox{colourThreeTint}{\strut\parbox{\dimexpr \linewidth-2\fboxsep}{\superitemlabelfont\color{colourThree}\twoparttitle{#1\quad}{#2}}}\nopagebreak\par\nopagebreak\addvspace{\smallskipamount}\nopagebreak\@afterheading
}{\par\if@ndrule\nopagebreak\@afterheading\par\tikz{\fill[color=colourThreeTint] (0,0) -- (\linewidth,0) [rounded corners=3mm] -- ++(0,-3mm)  -- ++(-\linewidth,0)  [rounded corners=0mm] --cycle;}\fi\pagebreak[3]\par\addvspace{\medskipamount}}


\newenvironment{activity}[1][]{\refstepcounter{activity}\@activitytrue
 \begin{activitystyle}{\activityname~\theactivity}{#1}}{\end{activitystyle}}



%Examples
\newcounter{example}

\newenvironment{examplestyle}[2]{\pagebreak[3]\par\addvspace{\medskipamount}%
{\superitemlabelfont\color{colourThree}
\medskip\hrule\nopagebreak
\rule[-.1\baselineskip]{0pt}{1.1\baselineskip}\twoparttitle{#1\quad}{#2}}%
\nopagebreak\par\nopagebreak\addvspace{\smallskipamount}\@afterheading
}{\par\addvspace{\medskipamount}\if@ndrule\nopagebreak\@afterheading\par\nopagebreak
\addvspace{\medskipamount}{\color{colourThree}\hrule}\fi%
\pagebreak[3]\par\addvspace{\medskipamount}}

\newenvironment{example}[1][]{\refstepcounter{example}%
\renewenvironment{solution}{\par\addvspace{\medskipamount}%
\mbox{\superitemlabelfont\color{colourThree}Solution}%
\nopagebreak\par\nopagebreak\addvspace{\medskipamount}}{}
\begin{examplestyle}{Example~\theexample}{#1}}{\end{examplestyle}}


%Tables

\setlength{\intextsep}{10pt plus 2pt minus 2pt}
%define a float style for table
\newcommand\fs@tables{%
  \def\@fs@capt##1##2{\parbox{\linewidth}{\raggedright{\tablehdfont ##1}\quad{\tablecaptfont ##2}}}%
  \def\@fs@pre{}%
  \def\@fs@post{\vspace{-1.5ex}}%to balance whitespace
  \def\@fs@mid{\vspace\abovecaptionskip\relax}%
  \let\@fs@iftopcapt\iftrue}
\floatstyle{tables}
\floatplacement{table}{H}
\restylefloat{table}
\floatevery{table}{\small}
\AtBeginEnvironment{table}{\gdef\CT@arc@{\color{colourTwo}}}
\AtEndEnvironment{table}{\gdef\CT@arc@{\color{black}}}


%define a float style for table*
\newcommand\fs@tablestars{%
  \def\@fs@capt##1##2{\parbox{\linewidth}{\raggedright\tablecaptfont ##2}\par}%
  \def\@fs@pre{}%
  \def\@fs@post{\vspace{-1.5ex}}%to balance whitespace
  \def\@fs@mid{}%
  \let\@fs@iftopcapt\iftrue}
\floatstyle{tablestars}
\newfloat{table*}{H}{lof}
\floatevery{table*}{\small}
\AtBeginEnvironment{table*}{\gdef\CT@arc@{\color{colourTwo}}}
\AtEndEnvironment{table*}{\gdef\CT@arc@{\color{black}}}


%widetables
\newenvironment{widetable}{\begin{fullwidth}[outermargin=\dimexpr-\marginparwidth-\marginparsep]\begin{table}\setlength{\hfuzz}{\dimexpr\marginparwidth+\marginparsep}}{\end{table}\end{fullwidth}}
\newenvironment{widetable*}{\begin{fullwidth}[outermargin=\dimexpr-\marginparwidth-\marginparsep]\begin{table*}\setlength{\hfuzz}{\dimexpr\marginparwidth+\marginparsep}}{\end{table*}\end{fullwidth}}


%Figures
%define a float style for figure
\newcommand{\fs@figures}{
  \def\@fs@capt##1##2{\parbox{\linewidth}{\raggedright{\fighdfont ##1}\quad{\figcaptfont ##2}}}%
  \def\@fs@pre{}%
  \def\@fs@post{\vspace{-1.5ex}}%to balance whitespace
  \def\@fs@mid{\addvspace{\abovecaptionskip}}%
  \let\@fs@iftopcapt\iffalse}
\floatstyle{figures}
\floatplacement{figure}{H}
\restylefloat{figure}
%mediacontent is the general environment for online media (audio, video, html5 etc.)
%\newenvironment{mediacontent}[1][]{\paragraph{#1}}{}
\floatname{mediacontent}{Media}
\newfloat{mediacontent}{H}{lof}


%define a float style for figure*
\newcommand\fs@figurestars{%
  \def\@fs@capt##1##2{\parbox{\linewidth}{\rule{0pt}{4ex}\raggedright\figcaptfont ##2}}%
  \def\@fs@pre{}%
  \def\@fs@post{\vspace{-1.5ex}}%to balance whitespace
  \def\@fs@mid{}%
  \let\@fs@iftopcapt\iffalse}
\floatstyle{figurestars}
\newfloat{figure*}{H}{lof}
\newfloat{mediacontent*}{H}{lof}

%widefigures
\newenvironment{widefigure}{\begin{fullwidth}[outermargin=\dimexpr-\marginparwidth-\marginparsep]\begin{figure}\setlength{\hfuzz}{\dimexpr\marginparwidth+\marginparsep}}{\end{figure}\end{fullwidth}}
\newenvironment{widefigure*}{\begin{fullwidth}[outermargin=\dimexpr-\marginparwidth-\marginparsep]\begin{figure*}\setlength{\hfuzz}{\dimexpr\marginparwidth+\marginparsep}}{\end{figure*}\end{fullwidth}}

%marginfigures
\newlength{\rhfight}
\NewEnviron{marginfigure}[1][]{\def\rhtmp{\begin{minipage}{\marginparwidth}\begin{figure}\BODY\end{figure}\end{minipage}}\settototalheight{\rhfight}{\rhtmp}\addtocounter{figure}{-1}\marginnote{\rhtmp}[\dimexpr #1-\rhfight+\intextsep-2\topsep]\let\rhtmp\relax}[]
\NewEnviron{marginfigure*}[1][]{\def\rhtmp{\begin{minipage}{\marginparwidth}\begin{figure*}\BODY\end{figure*}\end{minipage}}\settototalheight{\rhfight}{\rhtmp}\marginnote{\rhtmp}[\dimexpr #1-\rhfight+\intextsep-2\topsep]\let\rhtmp\relax}[]

%extra attributes for environments
\newcommand{\attrib}[1]{}
\newcommand{\metadata}[2]{}
\newcommand{\sourcereference}[1]{\begin{flushleft}\small #1\end{flushleft}}
\newcommand{\tablefootnote}[1]{\begin{flushleft}\small #1\end{flushleft}}
%itemrights command to be used withing a sourceref keyword of a media asset
%it can have two optional arguments (which are ignored at in the  PDF render)
\def\itemrights{\@ifnextchar[{\ack@argone}{\ack@plain{}{}}}
\def\ack@argone[#1]{\@ifnextchar[{\ack@argtwo[#1]}{\ack@plain{#1}{}}}
\def\ack@argtwo[#1][#2]{\ack@plain{#1}{#2}}
\newcommand{\ack@plain}[3]{\toks@{#1}\toks@{#2}\copyright~#3}

\newcommand{\captionprefix}[1]{\toks@{#1}}%temporary


%mediapath is like graphics path, but for VLE content
\newcommand{\mediapath}[1]{}


%icons (use text for drafting -- for now)
\newcommand{\newicon}[2]{\expandafter\gdef\csname icon@#1@symbol\endcsname{#2\,}}

\newcommand{\icon@@symbol}{}%no comma space
\newicon{calc}{\tikz{\draw (0,0) node[draw] {\textsc{CALC}};}}
\newicon{web}{\tikz{\draw (0,0) node[draw] {\textsc{WEB}};}}
\newicon{disc}{\tikz{\draw (0,0) node[draw] {\textsc{DISC}};}}
%example of using graphical icon
%\newicon{calc}{\includegraphics{calculator_cmyk_32}}
%attach up to three icons
%flush right on even pages (\if@tempswa set by marginnote)
\newcommand{\icons}[3]{\begin{marginfigure*}\if@tempswa\relax\else\hfill\fi\@nameuse{icon@#1@symbol}\@nameuse{icon@#2@symbol}\@nameuse{icon@#3@symbol}\end{marginfigure*}}

%glossary --- define when needed in book style
%\usepackage[toc,nogroupskip]{glossaries}
%\makeglossaries
 
%olink -- not highlighted --- link location added using attrib
\newenvironment{olink}{}{}
\ifx\href\undefined
\newcommand{\href}[2]{#2}
\fi

%thinks text
\newcommand{\thinks}[1]{\begin{tikzpicture}[draw=colourThree,line width=0.2]
\draw[fill=colourThree!40] (0.41,0.025) circle (0.011 and 0.013);
\draw[fill=colourThree!40] (0.365,0.037)  --  ++(0,0) [y={(0.2,0.8)}] circle  (0.015 and 0.022);
\draw[fill=colourThree!40] (0.313,0.068)  --  ++(0,0) [y={(0.3,0.7)}] circle  (0.024 and 0.03);
\draw[fill=colourThree!40] (0.27,0.12) .. controls +(0.09,-0.02) and +(0.01,0) .. (0.31,0.175) 
.. controls +(0.07,0.02) and +(0.01,0.01) .. (0.3,0.242)
.. controls +(0.03,0.05) and +(0.02,0.02) .. (0.23,0.29)
.. controls +(-0.05,0.07) and +(0.0,0.02) .. (0.127,0.295)
.. controls +(-0.045,0.045) and +(-0.01,0.02) .. (0.05,0.265)
.. controls +(-0.05,0.015 ) and +(-0.06,0.01) .. (0.04,0.195)
.. controls +(-0.045,-0.015) and +(-0.065,0.01) .. (0.052,0.122)
.. controls +(-0.015,-0.04) and +(-0.04,-0.04) .. (0.125,0.095)
.. controls +(0.015,-0.045) and +(-0.01,-0.04) .. (0.2,0.1)
.. controls +(0.045,-0.045) and +(0.01,-0.03) .. (0.27,0.12)
;
\end{tikzpicture}
{\color{colourThree}#1}
\begin{tikzpicture}[draw=colourThree,line width=0.2,xscale=-1]
\draw[fill=colourThree!40] (0.41,0.025) circle (0.011 and 0.013);
\draw[fill=colourThree!40] (0.365,0.037)  --  ++(0,0) [y={(0.2,0.8)}] circle  (0.015 and 0.022);
\draw[fill=colourThree!40] (0.313,0.068)  --  ++(0,0) [y={(0.3,0.7)}] circle  (0.024 and 0.03);
\draw[fill=colourThree!40] (0.27,0.12) .. controls +(0.09,-0.02) and +(0.01,0) .. (0.31,0.175) 
.. controls +(0.07,0.02) and +(0.01,0.01) .. (0.3,0.242)
.. controls +(0.03,0.05) and +(0.02,0.02) .. (0.23,0.29)
.. controls +(-0.05,0.07) and +(0.0,0.02) .. (0.127,0.295)
.. controls +(-0.045,0.045) and +(-0.01,0.02) .. (0.05,0.265)
.. controls +(-0.05,0.015 ) and +(-0.06,0.01) .. (0.04,0.195)
.. controls +(-0.045,-0.015) and +(-0.065,0.01) .. (0.052,0.122)
.. controls +(-0.015,-0.04) and +(-0.04,-0.04) .. (0.125,0.095)
.. controls +(0.015,-0.045) and +(-0.01,-0.04) .. (0.2,0.1)
.. controls +(0.045,-0.045) and +(0.01,-0.03) .. (0.27,0.12)
;
\end{tikzpicture}
}

%lists
\renewlist{enumerate*}{enumerate*}{2}
\setlist*[enumerate*]{before={\leavevmode\smallskip\newline},itemjoin=\qquad,afterlabel=~\rule[-2ex]{0pt}{4ex}~,label={\ifnum\@listdepth=\@ne(\alph*)\else(\roman*)\fi},}

\setlist{topsep=0pt,itemsep=0pt,partopsep=0pt}
\setlist[enumerate]{align=left,itemindent=0pt,labelindent=0pt,labelsep*=0.5em,labelwidth=!,leftmargin=*}
\setlist[enumerate,1]{label=(\alph*)}
\setlist[enumerate,2]{label=(\roman*),widest=iii}
\setlist[description]{labelsep*=1em}
\setlist[itemize]{align=left,itemindent=0pt,labelindent=0pt,labelsep*=0.5em,labelwidth=!,leftmargin=*}
\setlist[itemize,2]{label=$\circ$}
\setlist[trivlist]{topsep={0.5ex plus 0.05ex minus 0.05ex},itemsep=0pt,partopsep=0pt}%trivlist is used to format \[\]


\newlist{plainenumerate}{enumerate}{2}
\setlist[plainenumerate]{align=left,itemindent=0pt,labelindent=0pt,labelsep*=0.5em,labelwidth=!,leftmargin=*}
\setlist[plainenumerate,1]{label=\arabic*., ref=\arabic*}
\setlist[plainenumerate,2]{label=(\alph*)}

%marginnote styles
\renewcommand*{\raggedleftmarginnote}{\marginnotestyle}
\renewcommand*{\raggedrightmarginnote}{\marginnotestyle}

%add optional argument to pmatrix, bmatrix and vmatrix
\renewcommand*\env@matrix[1][*\c@MaxMatrixCols c]{%
  \hskip -\arraycolsep
  \let\@ifnextchar\new@ifnextchar
  \array{#1}}

%OU proofs
\newtheoremstyle{ouproof}
{\item[\theorem@headerfont\hskip\labelsep ##1\theorem@separator]} {\item[\theorem@headerfont\hskip \labelsep ##1\ ##3\theorem@separator]}
\theoremstyle{ouproof}
\theoremheaderfont{\titledboxheadfont\color{colourTwo}}
\theorembodyfont{}
\theoremseparator{\ }
\theoremsymbol{{\color{colourTwo}\ensuremath{\blacksquare}}}
\newtheorem{proof}{Proof}


%quote (as standard, but do not indent on right)
\renewenvironment{quote}{\list{}{\topsep=0pt}\item\relax}{\endlist}

%define macro for users to be able to design theorems etc with long titles
\newlength{\rhtmp}
\newcommand{\twoparttitle}[2]{\settowidth{\rhtmp}{#1}#1\parbox[t]{\dimexpr \linewidth-\rhtmp}{\raggedright #2}}

%for VLE XML -- instruction not to hyperlink reference
%This is useful occasionally to reference items that are allowed in TeX but not in SC XML
\let\refnolink\ref

%table of contents formatting
\RequirePackage{tocloft}
\renewcommand{\cftsecdotsep}{\cftnodots}
\renewcommand{\cftsubsecdotsep}{\cftnodots}
\renewcommand{\cftsubsubsecdotsep}{\cftnodots}
\renewcommand{\cfttoctitlefont}{\defaultheadfont\defaultheadfont\huge\color{colourThree}}

%fix AMS math required?
%\RequirePackage{mathtools}

%define \require, so that it can be used for mathJaX extras
\DeclareRobustCommand{\require}[1]{}

%headings for marginnotes
\newcommand{\marginhead}[1]{{\defaultheadfont #1}\rule[-\abovecaptionskip]{0pt}{0pt}\newline}

%comments
\if@nocomments
\DeclareRobustCommand*{\authorcomment}[1]{}
\DeclareRobustCommand*{\editorcomment}[1]{}
\else
\DeclareRobustCommand*{\authorcomment}[1]{{\color{red}#1}}
\DeclareRobustCommand*{\editorcomment}[1]{{\color{red!50!black}#1}}
\fi

\endinput