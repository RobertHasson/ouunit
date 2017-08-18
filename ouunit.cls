\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ouunit}[2016/05/1 1.08 (Robert Hasson, all rights reserved)]

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

%switch for simplified (no Tikz) output of boxes
\newif\if@previewonly
\@previewonlyfalse

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
\DeclareOption{quickpreview}{\@previewonlytrue}
\DeclareOption{nocomments}{\@nocommentstrue}
\DeclareOption{standalone}{\@standalonetrue}

%\ExecuteOptions{}

\ProcessOptions\relax
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load packages/class file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%add to global options to make equations flush left
\RequirePackage{etoolbox}
\if@standalone
\preto\@classoptionslist{fleqn,12pt,}
\LoadClass[fleqn,12pt]{article}
\else
\preto\@classoptionslist{fleqn,12pt,twoside,}
\LoadClass[fleqn,12pt,twoside]{article}
\fi


\RequirePackage{xcolor}
\if@reduced
\RequirePackage[papersize={210mm,263mm},text={30pc,54pc},marginpar=12pc,marginparsep=1pc,bindingoffset=-2cm,columnsep=12bp]{geometry}%
\else
\RequirePackage[a4paper,text={30pc,61pc},marginpar=12pc,marginparsep=1pc,bindingoffset=-2cm,columnsep=12bp]{geometry}%
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
\RequirePackage[nobottomtitles]{titlesec}
\RequirePackage{framed}
\RequirePackage{datetime}
\RequirePackage{fancyvrb}
\RequirePackage{float}
\RequirePackage[amsmath,thmmarks]{ntheorem}
\RequirePackage{adjmulticol}% includes standard multicol style
\RequirePackage{colortbl}
\RequirePackage[totoc]{idxlayout}

%if final then remove comments
\ifdraft\relax\else\@nocommentstrue\fi

%page style defaults
\raggedright
\raggedbottom 
\hyphenpenalty=10000
\setlength{\mathindent}{24pt}
\setlength{\leftmargin}{24pt}
\setlength{\parindent}{0pt}
\setlength{\parskip}{1ex plus 0.1ex minus 0.1ex}
\setlength{\topsep}{1ex  plus 0.1ex minus 0.1ex}%also for displayed eqn
\setlength{\partopsep}{0ex}%also for displayed eqn
\setlength{\itemsep}{0.5ex plus 0.05ex minus 0.05ex}
\setlength{\jot}{0.5ex plus 0.05ex minus 0.05ex}% separation of equations in align


%spacing around displayed math
%could also adjust skips for \small and \footnotesize 
\g@addto@macro\normalsize{%could be \appto
\setlength{\abovedisplayskip}{1ex plus 0.1ex minus 0.1ex}%
\setlength{\belowdisplayskip}{1ex plus 0.1ex minus 0.1ex}%
\setlength{\abovedisplayshortskip}{1ex plus 0.1ex minus 0.1ex}%
\setlength{\belowdisplayshortskip}{1ex plus 0.1ex minus 0.1ex}}

%metadata
\def\@faculty{Faculty of Science, Technology, Engineering and Mathematics}
\DeclareRobustCommand\faculty[1]{\DeclareRobustCommand\@faculty{#1}}

\DeclareRobustCommand\modulecode[1]{\renewcommand\@modulecode{#1}}
\DeclareRobustCommand\@modulecode{\@latex@error{No \noexpand\modulecode specified}\@ehc}

\DeclareRobustCommand\moduletitle[1]{\renewcommand\@moduletitle{#1}}
\DeclareRobustCommand\@moduletitle{\@latex@error{No \noexpand\moduletitle specified}\@ehc}

\DeclareRobustCommand\@unitid{}
\DeclareRobustCommand{\unitid}[1]{\DeclareRobustCommand\@unitid{#1}\DeclareRobustCommand\@title{Unit \@unitid\quad \@unittitle}}

\global\let\@unittitle\@empty
\DeclareRobustCommand{\unittitle}[1]{\DeclareRobustCommand\@unittitle{#1}\DeclareRobustCommand\@title{Unit \@unitid\quad \@unittitle}}

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


%lower resolution logo for smaller files if standalone
\if@standalone
\DeclareRobustCommand{\oulogo}{\includegraphics[width=3.5cm]{ou_compact_cmyk_24mm}}
\else
\DeclareRobustCommand{\oulogo}{\includegraphics[width=3.5cm]{ou_cmyk_masterlogo_29mm}}
\fi



\DeclareRobustCommand{\maketitle}{
\begin{adjmulticols}{1}{-1cm}{-1cm}
\hfuzz=100pt%do not report overfull hbox for title header
\begin{tabular}{l@{\qquad}p{13cm}}
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
\emph{\rule{0pt}{3ex}\large Prepared for the module team\ifx\@empty\@author\@empty \else\ by \@author\fi.}
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
\def\defaultheadfont{\usefont{OT1}{cmss}{bx}{n}}
\def\superitemlabelfont{\normalsize\usefont{OT1}{cmss}{bx}{n}}
\def\fighdfont{\small\usefont{OT1}{cmss}{bx}{n}}
\def\figcaptfont{\small\normalfont}
\def\tablehdfont{\small\usefont{OT1}{cmss}{bx}{n}}
\def\tablecaptfont{\small\normalfont}
\def\titledboxheadfont{\large\usefont{OT1}{cmss}{bx}{n}}
\def\runningheadstyle{\normalsize\usefont{OT1}{cmss}{bx}{n}\color{colourThree}}


%  Boxes 
% Define a Tikz background layer
\pgfdeclarelayer{background}
\pgfsetlayers{background,main}

%set space surrounding frame
\setlength{\OuterFrameSep}{2pt plus 2pt minus 2pt}

\if@previewonly
\newcommand{\roundedboxbottom}[3]{\colorbox{#1}{\hspace*{4mm}#3\hspace*{4mm}}}
\else
\newcommand{\roundedboxbottom}[3]{\tikz{\node[inner sep=4mm] (A) {#3};
  \begin{pgfonlayer}{background}   
  \fill[color=#1] (A.north west) -- (A.north east) [rounded corners=#2] -- 
         (A.south east)  -- (A.south west)  [rounded corners=0mm] -- cycle;
  \end{pgfonlayer}}}
\fi

\newenvironment{roundedbox}[1][colourFour]{% open (top or bottom) framed
  \def\FrameCommand{\roundedboxbottom{#1Tint}{4mm}}%
  \def\FirstFrameCommand{\roundedboxbottom{#1Tint}{0mm}}%
  \def\MidFrameCommand{\roundedboxbottom{#1Tint}{0mm}}%
  \def\LastFrameCommand{\roundedboxbottom{#1Tint}{4mm}}%
  \MakeFramed {\advance\hsize-8mm\FrameRestore}%
  }{\endMakeFramed}

\newenvironment{roundedtitledbox}[2][colourFour]{\begin{roundedbox}[#1]\setbox0\hbox{\mbox{\titledboxheadfont\color{#1} #2}}\ifdim\wd0=\z@\relax\else\box0\nopagebreak\par\fi}{\par\unskip\end{roundedbox}}

\newenvironment{style1box}[1][]{\begin{roundedtitledbox}[colourThree]{#1}}{\end{roundedtitledbox}}

\newenvironment{style2box}[1][]{\begin{roundedtitledbox}[colourTwo]{#1}}{\end{roundedtitledbox}}
 
\newenvironment{style4box}[1][]{\begin{roundedtitledbox}[colourFour]{#1}}{\end{roundedtitledbox}}

\if@previewonly
\newcommand{\semiopenbox}[2]{\fbox{\hspace*{4mm}#2\hspace*{4mm}}}
\else
\newcommand{\semiopenbox}[2]{\tikz{\node[inner sep=4mm] (A) {#2};
  \begin{pgfonlayer}{background}   
  \draw[color=#1] (A.north west) -- (A.north east) -- (A.south east)  -- (A.south west)  -- cycle;
  \end{pgfonlayer}}}
\fi
\newenvironment{colourframed}[1][colourTwo]{
  \def\FrameCommand{\semiopenbox{#1}}%
  \def\FirstFrameCommand{\semiopenbox{#1}}%
  \def\MidFrameCommand{\semiopenbox{#1}}%
  \def\LastFrameCommand{\semiopenbox{#1}}%
  \MakeFramed{\advance\hsize-8mm\FrameRestore}%
  }{\endMakeFramed}

\newenvironment{style3box}[1][]{\begin{colourframed}
\setbox0\hbox{\mbox{\titledboxheadfont\color{colourTwo} #1}}\ifdim\wd0=\z@\relax\else\box0\nopagebreak\par\fi}{\par\unskip\end{colourframed}}


\if@previewonly
\newcommand{\leftrulebox}[2]{{\color{#1}\rule{2.5mm}{1in}}\hspace*{1.5mm}#2}
\else
\newcommand{\leftrulebox}[2]{\tikz{\node[inner sep=4mm] (A) {#2};
  \path (A.south west) ++(1.5mm,0) coordinate (B);
  \begin{pgfonlayer}{background}
  \draw[line width=2.5mm,color=#1] (A.north west) ++ (1.5mm,0)  -- (B);
  \end{pgfonlayer}}}
\fi
\newenvironment{leftrule}[1][colourTwo]{
  \def\FrameCommand{\leftrulebox{#1}}%
  \def\FirstFrameCommand{\leftrulebox{#1}}%
  \def\MidFrameCommand{\leftrulebox{#1}}%
  \def\LastFrameCommand{\leftrulebox{#1}}%
  \MakeFramed{\advance\hsize-8mm\FrameRestore}%
  }{\endMakeFramed}

%online style for style4box
\newenvironment{onlinestyle4box}[1][]{\begin{leftrule}
\mbox{\titledboxheadfont\color{colourTwo} #1}\nopagebreak\par}{\par\unskip\end{leftrule}}

%section titles
\newcommand{\@ddheader}[1]{#1\ifttl@label\gdef\rightmark{\thesection\quad #1}\else\gdef\rightmark{#1}\fi}

\titleformat{\section}{\defaultheadfont\Large\color{colourThree}}{\thesection}{1em}{\@ddheader}
\titleformat{\subsection}{\defaultheadfont\large\color{colourTwo}}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\defaultheadfont\normalsize\color{colourTwo}}{\thesubsubsection}{1em}{}
\titleformat{\paragraph}{\defaultheadfont\normalsize\color{colourTwo}}{\theparagraph}{1em}{}
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
\fancypagestyle{plain}{\fancyhfoffset[LE]{\marginparsep+\marginparwidth}
\if@standalone
\relax
\else
\fancyhfoffset[RO]{\marginparsep+\marginparwidth}
\fi
\fancyhf{}
\fancyhead[LE]{\runningheadstyle\@title}
\fancyhead[RO]{\runningheadstyle\rightmark}
\fancyfoot[LE,RO]{\runningheadstyle\thepage}
\ifdraft
\fancyfoot[LO,RE]{\small Draft \@draftno\quad Last \LaTeX ed  \currenttime\ \today}
\fi
\renewcommand{\headrulewidth}{0pt}
\markboth{\@title}{\rightmark}
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

%define the format of solutions in place
\newenvironment{ip@solution}{\par\addvspace{\medskipamount}%
\mbox{\superitemlabelfont\color{colourThree}Solution}%
\nopagebreak\par\nopagebreak\addvspace{\medskipamount}\@afterheading%
\solutions@tup}{}

%format of exercise solutions at end
\newcommand{\printexercisesolutions}{\if@tend
      \immediate\closeout\exercises@write
\newpage\if@twocolsol\begin{adjmulticols}{1}{0pt}{-\marginparwidth}
\section*{Solutions to exercises}\end{adjmulticols}\else\section*{Solutions to exercises}\fi
\if@twocolsol\begin{adjmulticols}{2}{0pt}{-\marginparwidth}%
\setlist[enumerate]{align=left,leftmargin=0pt,labelindent=0pt,labelwidth=!,itemindent=2em,font=\textbf}%
\fi
\solutions@tup
\input{\jobname.ex}
\if@twocolsol\end{adjmulticols}\fi
\fi}



%format of activity solutions at end
\newcommand{\printactivitysolutions}{\if@tend
      \immediate\closeout\activities@write
\newpage\if@twocolsol\begin{adjmulticols}{1}{0pt}{-\marginparwidth}
\section*{Solutions to activities}\end{adjmulticols}\else\section*{Solutions to activities}\fi
\if@twocolsol\begin{adjmulticols}{2}{0pt}{-\marginparwidth}%
\setlist[enumerate]{align=left,leftmargin=0pt,labelindent=0pt,labelwidth=!,itemindent=2em,font=\textbf}%
\fi
\solutions@tup
\input{\jobname.act}
\if@twocolsol\end{adjmulticols}\fi
\fi}

%switch to solutions in place
\newcommand{\solutionsinplace}{\@tendfalse
\let\solution\ip@solution
\let\endsolution\endips@olution}

%switch to solutions at end
\newcommand{\solutionsatend}{\@tendtrue\DefineVerbatimEnvironment{solution}{mv@solution}{}}

%now setup the default
\if@tend\solutionsatend\else\solutionsinplace\fi


%Exercises
\newif\if@ndrule
\@ndruletrue
\newcommand{\noendrule}{\@ndrulefalse}

\newcounter{exercise}
\newcommand{\exercisename}{Exercise}

\newenvironment{exercisestyle}[2]{\par\addvspace{\medskipamount}%
{\superitemlabelfont\color{colourTwo}\medskip
\hrule\nopagebreak
\rule[-.1\baselineskip]{0pt}{1.1\baselineskip}%
#1\quad\parbox[t]{0.75\linewidth}{#2}}%
\nopagebreak\par\nopagebreak\addvspace{\smallskipamount}\@afterheading
}{\par\addvspace{\medskipamount}\if@ndrule\nopagebreak\@afterheading\par
  {\color{colourTwo}\hrule}\fi\pagebreak[1]
  \par\addvspace{\medskipamount}}

\newenvironment{exercise}[1][]{\refstepcounter{exercise}\begin{exercisestyle}{\exercisename~\theexercise}{#1}}{\end{exercisestyle}}


%Activities
\newcounter{activity}
\newcommand{\activityname}{Activity}

\newenvironment{activitystyle}[2]{\par\addvspace{\medskipamount}%
\mbox{\fboxsep 0pt\colorbox{colourThreeTint}{\parbox{\linewidth}{\rule[-0.5\baselineskip]{0pt}{1.7\baselineskip}\superitemlabelfont\color{colourThree}%
~#1\quad\parbox[t]{0.75\linewidth}{#2}}}}\nopagebreak\par\nopagebreak\addvspace{\smallskipamount}\@afterheading
}{\par\addvspace{\medskipamount}\vskip-\medskipamount\if@ndrule\nopagebreak\@afterheading\par\tikz{\begin{pgfonlayer}{background}   
  \fill[color=colourThreeTint] (0,0) -- (\textwidth,0) [rounded corners=3mm] -- 
         ++(0,-3mm)  -- ++(-\textwidth,0)  [rounded corners=0mm] -- cycle;
  \end{pgfonlayer}}\fi\pagebreak[1]
  \par\addvspace{\medskipamount}}

\newenvironment{activity}[1][]{\refstepcounter{activity}\@activitytrue
 \begin{activitystyle}{\activityname~\theactivity}{#1}}{\end{activitystyle}}



%Examples
\newcounter{example}

\newenvironment{examplestyle}[2]{\par\addvspace{\medskipamount}%
{\superitemlabelfont\color{colourThree}
\medskip
\hrule\nopagebreak
\rule[-.1\baselineskip]{0pt}{1.1\baselineskip}%
#1\quad\parbox[t]{0.75\linewidth}{#2}}%
\nopagebreak\par\nopagebreak\addvspace{\smallskipamount}\@afterheading
}{\par\addvspace{\medskipamount}\if@ndrule\nopagebreak\@afterheading\par\nopagebreak
  \addvspace{\medskipamount}{\color{colourThree}\hrule}\fi\pagebreak[1]
  \par\addvspace{\medskipamount}}

\newenvironment{example}[1][]{\refstepcounter{example}%
\renewenvironment{solution}{\par\addvspace{\medskipamount}%
\mbox{\superitemlabelfont\color{colourThree}Solution}%
\nopagebreak\par\nopagebreak\addvspace{\medskipamount}}{}
\begin{examplestyle}{Example~\theexample}{#1}}{\end{examplestyle}}


%Tables
%\arrayrulecolor{colourTwo}
\gdef\CT@arc@{\color{colourTwo}}

\setlength{\intextsep}{10pt plus 2pt minus 2pt}
%define a float style for table
\newcommand\fs@tables{%
  \def\@fs@capt##1##2{\parbox{\textwidth}{\raggedright{\tablehdfont ##1}\quad{\tablecaptfont ##2}}}%
  \def\@fs@pre{}%
  \def\@fs@post{\vspace{-1.5ex}}%to balance whitespace
  \def\@fs@mid{\vspace\abovecaptionskip\relax}%
  \let\@fs@iftopcapt\iftrue}
\floatstyle{tables}
\floatplacement{table}{H}
\restylefloat{table}

%define a float style for table*
\newcommand\fs@tablestars{%
  \def\@fs@capt##1##2{\parbox{\textwidth}{\raggedright\tablecaptfont ##2}\par}%
  \def\@fs@pre{}%
  \def\@fs@post{\vspace{-1.5ex}}%to balance whitespace
  \def\@fs@mid{}%
  \let\@fs@iftopcapt\iftrue}
\floatstyle{tablestars}
\newfloat{table*}{H}{lof}


%Figures
%define a float style for figure
\newcommand{\fs@figures}{
  \def\@fs@capt##1##2{\parbox{\textwidth}{\raggedright{\fighdfont ##1}\quad{\figcaptfont ##2}}}%
  \def\@fs@pre{}%
  \def\@fs@post{\vspace{-1.5ex}}%to balance whitespace
  \def\@fs@mid{\addvspace{\abovecaptionskip}}%
  \let\@fs@iftopcapt\iffalse}
\floatstyle{figures}
\floatplacement{figure}{H}
\restylefloat{figure}

%define a float style for figure*
\newcommand\fs@figurestars{%
  \def\@fs@capt##1##2{\parbox{\textwidth}{\raggedright\figcaptfont ##2}}%
  \def\@fs@pre{}%
  \def\@fs@post{\vspace{-1.5ex}}%to balance whitespace
  \def\@fs@mid{}%
  \let\@fs@iftopcapt\iffalse}
\floatstyle{figurestars}
\newfloat{figure*}{H}{lof}

%widefigures
\usepackage{fullwidth}
\newenvironment{widefigure}{\begin{fullwidth}[outermargin=\dimexpr-\marginparwidth-\marginparsep]\begin{figure}\setlength{\hfuzz}{\dimexpr\marginparwidth+\marginparsep}}{\end{figure}\end{fullwidth}}
\newenvironment{widefigure*}{\begin{fullwidth}[outermargin=\dimexpr-\marginparwidth-\marginparsep]\begin{figure*}\setlength{\hfuzz}{\dimexpr\marginparwidth+\marginparsep}}{\end{figure*}\end{fullwidth}}

%marginfigures
\newlength{\rhfight}
\NewEnviron{marginfigure}[1][]{\def\rhtmp{\begin{minipage}{\marginparwidth}\begin{figure}\BODY\end{figure}\end{minipage}}\settototalheight{\rhfight}{\rhtmp}\addtocounter{figure}{-1}\marginnote{\rhtmp}[\dimexpr #1-\rhfight+\intextsep-2\topsep]\let\rhtmp\relax}{}
\NewEnviron{marginfigure*}[1][]{\def\rhtmp{\begin{minipage}{\marginparwidth}\begin{figure*}\BODY\end{figure*}\end{minipage}}\settototalheight{\rhfight}{\rhtmp}\marginnote{\rhtmp}[\dimexpr #1-\rhfight+\intextsep-2\topsep]\let\rhtmp\relax}{}

%extra attributes for environments
\newcommand{\attrib}[1]{}
\newcommand{\metadata}[2]{}

%icons (use text for drafting -- for now)
\newcommand{\icon@@symbol}{}
\newcommand{\icon@calc@symbol}{\tikz{\draw (0,0) node[draw] {\textsc{CALC}};}\,}
\newcommand{\icon@web@symbol}{\tikz{\draw (0,0) node[draw] {\textsc{WEB}};}\,}
\newcommand{\icon@disc@symbol}{\tikz{\draw (0,0) node[draw] {\textsc{DISC}};}\,}
%attach up to three icons
%flush right on even pages (\if@tempswa set by marginnote)
\newcommand{\icons}[3]{\marginnote{\if@tempswa\relax\else\hfill\fi\@nameuse{icon@#1@symbol}\@nameuse{icon@#2@symbol}\@nameuse{icon@#3@symbol}}}

%glossary --- do we need this?
%\usepackage[nomain]{glossaries}
%\makeglossaries
 
%olink -- not highlighted --- link location added using attrib
\newenvironment{olink}{}{}

%thinks text
\newcommand{\thinks}[1]{\tikz{\path[fill=colourThree!20] (0,0) circle (0.15 and 0.1) (0.1,-0.15) circle (0.08 and 0.04) (0.2,-0.22) circle (0.06 and 0.03);}~{\color{colourThree}#1}~\tikz{\path[fill=colourThree!20] (0,0) circle (0.15 and 0.1) (-0.1,-0.15) circle (0.08 and 0.04) (-0.2,-0.22) circle (0.06 and 0.03);}}

%lists
\renewlist{enumerate*}{enumerate*}{2}
\setlist*[enumerate*]{before={\leavevmode\smallskip\newline},itemjoin=\qquad,label={\ifnum\@listdepth=\@ne\protect\rule{0pt}{3ex}(\alph*)~\else\protect\rule{0pt}{3ex}(\roman*)~\fi}}

\setlist{topsep=0pt,itemsep=0pt,partopsep=0pt}
\setlist[enumerate]{align=left,itemindent=0pt,labelindent=0pt,labelsep*=0.75em,labelwidth=!,leftmargin=*}
\setlist[enumerate,1]{label=(\alph*)}
\setlist[enumerate,2]{label=(\roman*)}
\setlist[description]{labelsep*=1em}
\setlist[itemize]{leftmargin=1em,labelwidth=!}
\setlist[itemize,2]{label=$\circ$}
\setlist[trivlist]{topsep=0pt,itemsep=0pt,partopsep=0pt}


%marginnote styles
\renewcommand*{\raggedleftmarginnote}{\raggedright\normalfont\normalsize\color{black}\setlength{\mathindent}{0pt}}
\renewcommand*{\raggedrightmarginnote}{\raggedright\normalfont\normalsize\color{black}\setlength{\mathindent}{0pt}}

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
\renewenvironment{quote}{\list{}{}\item\relax}{\endlist}

%define macro for users to be able to design theorems etc with long titles
\newlength{\rhtmp}
\newcommand{\twoparttitle}[2]{\settowidth{\rhtmp}{#1}#1\parbox[t]{\dimexpr \textwidth-\rhtmp}{\raggedright #2}}

%for VLE XML -- instruction not to hyperlink reference
%This is useful occasionally to reference items that are allowed in TeX but not in SC XML
\let\refnolink\ref

%table of contents formatting
\RequirePackage{tocloft}
\renewcommand{\cftsecdotsep}{\cftnodots}
\renewcommand{\cftsubsecdotsep}{\cftnodots}
\renewcommand{\cftsubsubsecdotsep}{\cftnodots}

%fix AMS math required?
%\RequirePackage{mathtools}

%define \require, so that it can be used for mathJaX extras
\DeclareRobustCommand{\require}[1]{}

%comments
\if@nocomments
\DeclareRobustCommand*{\authorcomment}[1]{}
\DeclareRobustCommand*{\editorcomment}[1]{}
\else
\DeclareRobustCommand*{\authorcomment}[1]{{\color{red}#1}}
\DeclareRobustCommand*{\editorcomment}[1]{{\color{red!50!black}#1}}
\fi

\endinput