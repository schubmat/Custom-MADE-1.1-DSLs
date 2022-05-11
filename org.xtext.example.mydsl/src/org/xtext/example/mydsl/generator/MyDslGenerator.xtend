/*
 * generated by Xtext 2.16.0
 */
package org.xtext.example.mydsl.generator

import org.eclipse.emf.ecore.resource.Resource
import org.xtext.example.mydsl.myDsl.Model
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class MyDslGenerator extends AbstractGenerator {

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		
		val model = resource.contents.head as Model;
		val decisionRecord = model.records.head;
		val fileName = resource.URI.trimFileExtension.lastSegment

//		fsa.generateFile(fileName + ".java", '''
//			public class «fileName» {
//			    
//			    public static void main(String[] args) {
//
//			    }
//			    
//			}
//		''')
//
		fsa.generateFile(fileName + ".md", '''
			# «model.records.head.title.name» 
			    
			**User story:** «decisionRecord.userStory.ticket»
			
			«decisionRecord.summary.summary»

			## Considered Alterantives
			
			«FOR alt : decisionRecord.consideredAlteratives.alternatives»
				* «alt.value»
			«ENDFOR»

			## Decision Outcome

			* **Chosen Alternative:** «decisionRecord.outcome.selected.selection.value»
			* **Reason:** «decisionRecord.outcome.rationale.name»
		''')	
		
		fsa.generateFile(fileName + ".tex", '''
			% ==================================================================================
			% ==================================================================================
			%
			%                           «model.records.head.title.name»
			%
			% ==================================================================================
			% ==================================================================================
			%
			% Titel des Projektes
			\newcommand{\topic}{«model.records.head.title.name»}
			% include header (for an constitant document layout)
			
			% ==================================================================================
			% ==================================================================================
			%
			%                          DOCUMENT HEADER
			%
			% ==================================================================================
			% ==================================================================================
			%
			% ==================================================================================
			% Globale Variablen, die schon im Header benötigt werden
			% ==================================================================================
			%
			% Semester der Veranstaltung
			\newcommand{\currSem}{Wintersemester 2018}
			% Namen der Authoren und Einrichtung
			\newcommand{\authors}{LS Software-Systemtechnik}
			\newcommand{\institute}{BTU Cottbus - Senftenberg}
			% Veranstaltung
			\newcommand{\project}{Entwicklung von Software-Systemen}
			% Assemblerdateien auf dem BS Webserver
			\newcommand{\pdf}[1]{\textbf{\href{http://www-sst.informatik.tu-cottbus.de/Uebungsmaterial/EntwicklungvonSoftware-Systemen/#1.pdf}{#1}}}
			% Author Mail
			\newcommand{\authMail}[0]{\textbf{\href{mailto:M.Schubanz@b-tu.de}{M.Schubanz@b-tu.de} }}
			%
			% ==================================================================================
			% KLASSEN UND PAKET DEKLARATION 
			% ==================================================================================
			%
			% ----------------------------------------------------------------------------------
			% Basis Konfiguration des Dokumentes
			\documentclass[fontsize=10pt, a4paper, DIV13, german, parskip, enabledeprecatedfontcommands]{scrartcl}
			%
			% ----------------------------------------------------------------------------------
			%	Neue Deutsche Rechtschreibung laden
			\usepackage[ngerman]{babel} 		% German language with new orthography
			% \usepackage[english, UKenglish]{babel} % Englisch
			%	fuer die Nutzung von Umlauten... " vor a oder o oder u eingeben
			%
			%\usepackage[utf8]{inputenc}			% UTF-8 Support
			\usepackage[utf8x]{inputenc}		% UTF-8 Support wenn LaTeX sich beschwert
			%\usepackage[latin1]{inputenc}		% fuer Unix und ANSI Kodierung
			\usepackage[T1]{fontenc}			% T1 Fonts fÃ¼r die Schrift Enkodierung
			%
			% [UTF8] is "supported" by the LaTeX team and covers a fairly specific/limited 
			% range of unicode input characters. It only defines those symbols that are known 
			% to be available with the current font encoding.
			%
			% [UTF8x], AFAIK, is no longer supported, but covers a much broader range of input 
			% symbols. I would recommend only trying it if [UTF8] doesn't do what you need.
			%
			% Secondly, the listings package (and most other related packages that do character 
			% scanning) does not support UTF8 input. The listingsutf8 package provides a 
			% UTF8-compatible replacement for \lstinputlisting but not for the main \lstlisting
			% environment. Using XeLaTeX might help you here, however.
			%
			% More infos about Internationalization in LaTex: 
			% http://en.wikibooks.org/wiki/LaTeX/Internationalization
			%
			\usepackage[babel,german=quotes]{csquotes}
			%
			\usepackage{lastpage}
			\usepackage{mathptmx}
			\usepackage{eurosym}
			\usepackage[scaled=.90]{helvet}
			\usepackage{courier}
			%
			\usepackage[T1]{url}    % Web-Adressen auch mit T1-Encoding
			\urlstyle{tt}           % und in tt-Font
			%
			%
			% spezielle PDF-Unterstützung(Hyperlinks, Bookmarks) für die PDF-Datei Erstellung
			\usepackage[                                            %
			    pdftitle={\topic},                                  %
			    pdfsubject={\project},                              %
			    pdfauthor={\authors},                               %
			    colorlinks,                                         %
			    urlcolor=blue,                                      %
			    citecolor=red,                                      %
			    linkcolor=blue,                                     %
			    breaklinks=true,                                    %
			    pdfpagemode=UseOutlines,                            %
			    plainpages=false,                                   %
			    pdfpagelabels,                                      %
			    bookmarksnumbered,                                  %
			    bookmarksopen,                                      %
			    pdfstartview=FitV,                                  %
			    pdfpagelayout=SinglePage                            %
			]{hyperref}
			%
			\usepackage{multirow}
			\usepackage{graphicx}   % Graphikpaket, Einbinden von Bildern
			\usepackage{tabularx}   % automatische Spaltenbreite
			\usepackage{colortbl}
			\usepackage{supertabular}
			\usepackage{longtable}  % Tabellen, die über mehr als eine Seite gehen
			%\usepackage{arydshln}   % gestrichelte Linien in Tabellen
			\usepackage{booktabs}   % toprule, midrule in Tabellen
			\usepackage{comment}	% Unterstützung für verschiedene Versionen
			\usepackage{moreverb}	% Unterstützung von nummerierten Listungs
			\usepackage{listings}	% erweiterte Unterstützung für Quellcode Einbindung
			\usepackage{float}     % Option H für Figure Umgebung, Platzierung genau 
			                          % an der Stelle
			\usepackage{enumerate}	% mehr Optionen für Enumerate Umgebungen
			\usepackage{enumitem}   % Stil von Aufzählungen anpassbar machen
			\usepackage{longtable}	% Table to be used when spreading a tabular over multiple pages
			\usepackage{caption}
			\usepackage{eurosym} 	% euro symbol
			\usepackage{lastpage}	% Anzeige der letzten Seitenzahl
			%\usepackage{fancydhr}	% Paket, dass Abbildungen im Header unterstützt
			\usepackage{scrlayer-scrpage} 	% Umdefinieren von Headern und Footern für KOMA Skript
			%\usepackage{svg} 		% Das Laden von SVG Grafiken ermöglichen
			% Möglichst als letztes Paket laden
			%\usepackage{todonotes}  % Unterstützung von todo-Elementen 
			%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%
			% Pakete der tikz-Library (snakes ist veraltet, decorations ist neu)
			% \usepackage{tikz} % drawing support
			% \usetikzlibrary{positioning} % load positioning library
			% \usetikzlibrary{decorations.pathmorphing} % used for sneaking lines
			% \usetikzlibrary{backgrounds} % changing backgrounds
			% \usetikzlibrary{arrows} % load positioning library
			% \usetikzlibrary{fit} % compute object sizes
			% \usetikzlibrary{petri} % petri net library !?
			% \usetikzlibrary{calc} % calculate positions and so on!?
			% \usepackage{tikz-uml}
			%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%
			% -----------------------------------------------------------------------------
			% listing settings
			% -----------------------------------------------------------------------------
			% Standard-Sprache und deren Optionen setzen
			\usepackage{listings}           % include listings
			%
			\lstset{%
			    language=Java,              % Sprachentyp definieren
			    numbers=left,               % Zeilennummern links
			    stepnumber=1,               % Jede Zeile nummerieren.
			    keywordstyle=\color{violet}\textbf,
			        % numbersep=5pt,                % Abstand der Nummern zum Quellcode
			        numberstyle=\footnotesize,               % Zeichengr<F6>sse f<FC>r die Nummern.
			        breaklines=true,                % Zeilen umbrechen wenn notwendig.
			        breakautoindent=true,           % Nach dem Zeilenumbruch Zeile einr<FC>cken.
			        postbreak=\space,               % Bei Leerzeichen umbrechen.
			        tabsize=3,                      % Tabulatorgroesse 
			        numbersep=20pt,
			    basicstyle=\small\fontfamily{cmtt},     % Nichtproportionale Schrift, klein f<FC>r den Quellcode
			        showspaces=false,               % Leerzeichen nicht anzeigen.
			        showstringspaces=false,         % Leerzeichen auch in Strings ('') nicht anzeigen.
			        extendedchars=true,             % Alle Zeichen vom Latin1 Zeichensatz anzeigen.
			    emphstyle = \underbar,
			    captionpos = t,
			    xleftmargin=0pt,
			    xrightmargin=-120pt,
			    framexleftmargin=7pt,
			    framexrightmargin=7pt,
			    framextopmargin=5pt,
			    framexbottommargin=5pt,
			    frame=rtlb %
			}
			\lstloadlanguages{% Check Dokumentation for further languages ...
			         %[Visual]Basic
			         %Pascal
			         %C
			         %C++
			         %XML
			         %HTML
			         Java
			}
			%
			%
			% ==================================================================================
			% UMGEBUNG 
			% ==================================================================================
			%
			% Text-Formatierungen als neue, einfachere Kommandos
			\newcommand{\kommentar}[1]{\noindent\fbox{\fbox{\parbox{\textwidth}{#1}}}}
			\newcommand{\ausblenden}[1]{}
			% \newcommand{\omnet}{\textsc{OMNeT++}}
			\newcommand{\code}[1]{\texttt{#1}}
			\newcommand{\costubs}{{CoStuBS} }
			%
			% Neuberechnung der Text Area
			\typearea[current]{last}
			%
			\renewcommand{\baselinestretch}{1.1}
			%
			\pagestyle{scrheadings}								% Definition des Pagelayouts
			%\lhead{}
			%\chead{}
			%\rhead{\includegraphics[scale=0.35]{BTULogoKompakt.eps}}
			\ihead[]{\includegraphics[scale=.75]{BTULogoKompakt}}
			\chead{\today}
			\ohead[]{\authors\\\project}
			\cfoot{Seite \thepage\ von \pageref{LastPage}}		% Seite 1 von X im Footer
			%
			% ----------------------------------------------------------------------------------
			% Unterstützung für die Anzeige von Lösungen zu den einzelnen Aufgaben
			%
			\newenvironment{smallitemize}   % Umgebung mit winzigen vertikalen Abstaenden
			{
			    \begin{list}{$\bullet$ \ }{}
			        \setlength{\topsep}{0pt}
			        \setlength{\parskip}{0pt}
			        \setlength{\partopsep}{0pt}
			        \setlength{\parsep}{0pt}         
			        %\setlength{\itemsep}{0pt} 
			}
			{
			    \end{list} 
			}
			
			\setlength{\parskip}{2pt}
			\setlength{\partopsep}{1pt}
			\setlength{\parsep}{1pt}         
			
			\usepackage[tmargin=80pt, lmargin=80pt, tmargin=95pt, headsep=3.5em]{geometry}
			% Umgebung fuer Loesungen zu Kontrollfragen
			% Achtung: \begin{loesung} muss unbedingt am Anfang der Zeile stehen!
			\specialcomment{loesung}{\begin{smallitemize}\color{red}\lstset{rulecolor=\color{red}}}{\end{smallitemize}}
			%
			% Loesung an- und ausschalten
			% \includecomment{loesung}    % Loesung zu Kontrollfragen im PDF-Dokument anzeigen
			% \excludecomment{loesung} % Loesung zu Kontrollfragen im PDF-Dokument ausblenden
			%
			%
			% Loesung an- und ausschalten
			% \includecomment{loesung}    % Loesung zu Kontrollfragen im PDF-Dokument anzeigen
			% \excludecomment{loesung} % Loesung zu Kontrollfragen im PDF-Dokument ausblenden
			%
			%
			% ==================================================================================
			% define standard title page layout
			% ==================================================================================
			\newcommand{\intro}{%
			\pdfbookmark[1]{\topic}{titleanc}
			%
			% ----------------------------------------------------------------------------------
			% Header
			% ----------------------------------------------------------------------------------
			%
			%
			\begin{figure}[!h]
				\vspace{-1.1cm}\hspace*{.15cm}
				%\includegraphics[scale=.65]{../BTULogoKompakt}
			\end{figure}
			%
			\vspace{-4em}
			%
			\begin{center}
			    \rule{.925\textwidth}{0.25pt}\\[0.35cm]
			    \textbf{\Large{\topic}}\\
			    \rule{.925\textwidth}{0.25pt}\\[0.6cm]
			\end{center}
			}
			
			%\input{../Header.tex}
			%\input{solutions.tex}
			%
			%
			% ==================================================================================
			% DOKUMENT-BEGINN 
			% ==================================================================================
			%
			\begin{document}
			%
			% standard document begin (headline etc)
			\intro
			%
			
			\section*{User Story}
			
			\begin{itemize}
				\item «decisionRecord.userStory.ticket»
			\end{itemize}
			
			\section*{Summary}
			
			\begin{itemize}
				\item «decisionRecord.summary.summary»
			\end{itemize}
			
			\section*{Considered Alterantives}
			
			\begin{enumerate}
				«FOR alt : decisionRecord.consideredAlteratives.alternatives»
					\item «alt.value»
				«ENDFOR»
			\end{enumerate}			

			\section*{Decision Outcome}
			
			\subsubsection*{Chosen Alternative}
			
			\begin{itemize}
				\item «decisionRecord.outcome.selected.selection.value»
			\end{itemize}
			
			\subsubsection*{Reason}

			\begin{itemize}
				\item «decisionRecord.outcome.rationale.name»
			\end{itemize}
			
			%
			\end{document}

		''')

	}
}
