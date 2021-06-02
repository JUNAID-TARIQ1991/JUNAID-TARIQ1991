echo
echo
echo "***********POWHEG BOX V2****************"
echo 
echo 
echo "*******Production cross section for vector boson Z *******"
echo
echo 
echo "******using NNPDF31-00108NNLO PDF SET*******"
echo 
echo 
echo 
cd /home/junaid/POWHEG-BOX-V2/Z
inputname1=$1

currentdir=$PWD
cd /home/junaid/POWHEG-BOX-V2/Z/Zorigional/
Zorigional=$PWD
echo $PWD
cd ..
echo $PWD

if [ -f $inputname1 ]
    
then
echo 'file' /$inputname1 'found'
cd $currentdir/$inputname1/


else
    echo 'creating ' $currentdir/$inputname1
    mkdir -p $currentdir/$inputname1
    cd $currentdir/$inputname1/
    
fi
echo $PWD


echo "This set has 100 member PDFs. mem=0 --> central value; mem=1-100 --> eigenvector sets"
echo
echo 
echo
echo "For central value set pdf index to 322500 and for eigenvectors set 322501-322599.  "
echo
echo
echo
echo "***********************set the pdf index************************"
echo
echo
echo
echo
read pdfindex
pdf=$pdfindex
if [ -f $pdf ] 
then
    echo 'pdfset' $pdf 'found'
    cd $PWD/$pdf/
else
    echo 'creating directory' $PWD/$pdf
    mkdir -p $PWD/$pdf
    cp -RT $Zorigional $currentdir/$inputname1/$pdf/
    cd $PWD/$pdf
fi
echo '=====>' $PWD

#ls
cd $PWD/testrun-lhc-8TeV
#ls
echo $PWD
sed -i -e '9,10 s/4000d0/6500d0/g' $PWD/powheg.input
sed -i -e '12,13 s/21100/'$pdf'/g'  $PWD/powheg.input
#vim powheg.input
echo
echo
echo
echo
echo
read -r -p "are you sure to execute ./..pwhg_main? [Y/N]" response
case "$response" in
[yY][eE][sS]|[yY] )
./../pwhg_main
;;
[nN][oO] | [nN] )
echo 'exiting'
;;
* )
echo 'invalid response'
;;
esac
    
