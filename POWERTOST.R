# Author: PharmCat
# Version = 1.0.0


Run <- function(args) {
    #Execute the POWERTOST command

    cmdname = args[[1]]
    args = args[[2]]
    oobj = spsspkg.Syntax(list(
        spsspkg.Template("CMD", subc="", var="cmd", ktype="str"),
        spsspkg.Template("VAL", subc="CV", var="cv", ktype="float", vallist=list(0.0, 1.0)),
		spsspkg.Template("VAL", subc="POWER", var="power", ktype="float", vallist=list(0.0, 1.0)),
		spsspkg.Template("ALPHA", subc="", var="alpha", ktype="float", vallist=list(0.0, 1.0)),
		spsspkg.Template("THETA0", subc="GMR", var="theta0", ktype="float", vallist=list(-1.0, 1.0)),
		spsspkg.Template("THETA1", subc="BEL", var="theta1", ktype="float", vallist=list(0.0, 2.0)),
		spsspkg.Template("THETA2", subc="BEL", var="theta2", ktype="float", vallist=list(0.0, 2.0)),
		spsspkg.Template("DESIGN", subc="", var="design", ktype="str"),
		spsspkg.Template("VAL", subc="N", var="n", ktype="int")
        ))

    res <- spsspkg.processcmd(oobj, args, "exec")
    
}


exec<-function(cmd, cv=0.2, n=18, design="2x2", power=0.8, theta0=1, theta1=0.8, theta2=1.25, alpha=0.05){

	library(PowerTOST)
	if (cmd == "powertost") {
		title = "power.TOST"
		result <- data.frame("Design"=design, "Alpha"= alpha, "N" = n, "Lower CI" = theta1,"Upper CI" = theta2,  "Power" = 0)
		result["Power"] <- power.TOST (alpha=alpha, theta0=theta0, theta1=theta1, theta2=theta2, CV=cv, n=n, design=design)

	}

	else if (cmd == "samplentost") {
		title = "sampleN.TOST"
		result <- sampleN.TOST(alpha=alpha, targetpower=power, theta0=theta0, theta1=theta1, theta2=theta2, CV=cv, design=design)
	}
	else if (cmd == "cvfromci") {
		title = "CVfromCI"
		result <- data.frame("Design"=design, "Alpha"= alpha, "N" = n, "Lower CI" = theta1,"Upper CI" = theta2, "CV" = 0)
		result["CV"] <- CVfromCI(lower=theta1, upper=theta2, n=n, design=design, alpha=alpha)
	}
	else {
	
		title = "NO RESULT"
		result <- data.frame("NO" = 0)

	}



rownames(result)[1] <- "Result"
spsspivottable.Display(result,
title="PowerTOST",
rowdim="Row",
hiderowdimtitle=TRUE,
coldim = gettext(title),
hidecoldimtitle=FALSE)

    
}