IBM SPSS brige to R Project PowerTOST library.

Implemented: sampleN.TOST, power.TOST, CVfrovCI. 

Syntax:

POWERTOST CMD=[POWERTOST|SAMPLENTOST|CVFROMCI] ALPHA=Number DESIGN="[PARALLEL|2X2|2X2X4]" QuotedString

/GMR THETA0=Number *

/BEL THETA1=Number THETA2=Number **

/CV VAL=Number1

/POWER VAL=Number2

/N VAL=Number2,3

* Required for sampleN.TOST
**Required
1* Required for samplen.TOST
2* Required for samplen.TOST
3* Required for power.TOST, CVfomCI