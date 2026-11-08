\name{README}
\title{Getting started with your Lab Sandbox}

\section{ }{
You can find important course-specific tips and notes for your Lab Sandbox in \cr
this quick guide to use throughout your course. You’ll be able to reference this \cr
at any time or visit the \href{https://learner.coursera.help/hc/articles/360062301971}{Learner Help Center} 
for more info. 
}

\section{What tools are already installed in my sandbox environment?}{
\itemize{
  \item caret 
	\item kernlab
	\item knitr
	\item pgmm
	\item ISLR
	\item quantmod
	\item ggplot2
	\item AppliedPredictiveModeling
	\item ElemStatLearn which has been removed from the CRAN repository and is only available in the archives. This has been preinstalled
	\item rpart
	\item gbm
	\item lubridate
	\item forecast
	\item e1071
}
}

\section{How can I use preinstalled libraries in my Sandbox?}{
\itemize{
   
    \item You can load the library using library(packagename).
}
}

\section{Using Provided Datasets }{
Throughout this course, you'll encounter datasets which are hosted on other websites. If you'd like to complete your work in the lab sandbox environment, please download these datasets from their listed websites and upload the data files directly into your RStudio lab environment. Lab Sandboxes have limited access to external sites, so uploading your data files directly will help ensure you do not hit any access errors.
}

\section{How can I use Knitr in my Sandbox?}{
\itemize{
    \item If you'd like to compile your R Markdown document and convert it to HTML, you'll need the knitr package.
    \item \strong{IMPORTANT NOTE: for knitr to generate and preview your HTML file appropriately, please follow the instructions below.\cr If you do not follow these instructions, you may see a blank HTML file output.} \cr
    \enumerate{
         \item In your upper Lab Sandbox toolbar and click the "Help" icon \cr
        \item Select the "switch back to the old lab experience" URL in the help modal that appears. \cr
        \item This will open RStudio in a new browser tab, without the surrounding iframe or "Help" icon. \cr
        \item You should be able to successfully use knitr to produce the HTML output once you are in a separate window. \cr
        \item If you'd like to use the toolbar again at any point, you can relaunch your lab sandbox from the course week view and it will               appear. \cr
        }
       \item If you choose to leverage RPubs, please run library(rsconnect) in your console first to prevent connection issues.
      \item You can also choose the HTML file from bottom right quadrant and click on More option from the menu bar and choose Export to download the HTML into your local machine.
}
}
\section{Using Github in this Sandbox}{
You can perform basic HTTPS Github commands, such as git clone in this sandbox without any additional setup. If you choose to link your sandbox for version control, please note that you'll want to link your Github to your RStudio Sandbox lab first. This can be done in the Tools > Global Options > Git/SVN settings. You'll want to create a RSA key in these settings as well.

\href{preview?file=~\%2FREADME.rd}{Go back to README.md}

}
