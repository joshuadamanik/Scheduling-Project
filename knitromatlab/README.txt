Using Artelys Knitro with MATLAB(R)
-----------------------------------

This directory contains the interface files necessary to use Artelys Knitro
from MATLAB.  The "examples" subdirectory contains several example codes
illustrating how to solve different types of optimization models using this
Knitro-MATLAB interface.


Interface Files
---------------

The following files are needed to use the Knitro-MATLAB interface.  They
must be in the directory in which you run your model (or some other special
directory where MATLAB automatically searches for files).

knitromatlab_mex.mexw64  The Knitro-MATLAB Mex interface file.

knitro_lp.p              This function implements the Knitro-MATLAB API for
                         linear programs (LPs). Please see "exampleLP1.m" in
			 "examples" for an example of using this function.

knitro_milp.p            This function implements the Knitro-MATLAB API for
                         mixed-integer linear programs (MILPs). Please see
			 "exampleMILP1.m" in "examples" for an example of using
                         this function.

knitro_minlp.p           This function implements the Knitro-MATLAB API for
                         mixed-integer nonlinear programs (MINLPs). Please see
			 "exampleMINLP1.m" in "examples" for an example of using
                         this function.

knitro_nlneqs.p          This function implements the Knitro-MATLAB API for
                         nonlinear systems of equations.  Please see
                         "exampleNLEQ1.m" in "examples" for an example of using
			 this function.

knitro_nlnlsq.p          This function implements the Knitro-MATLAB API for
                         nonlinear least squares models.  Please see
                         "exampleLSQ*.m" in "examples" for examples of using
			 this function.

knitro_nlp.p             This function implements the Knitro-MATLAB API for
                         general nonlinear programs (NLPs). Please see
			 "exampleNLP*.m" in "examples" for examples of using
			 this function.

knitro_qcqp.p            This function implements the Knitro-MATLAB API for
                         quadratically constrained quadratic programs (QCQPs).
			 This function supports both convex and non-convex
			 QCQPs and also may be used to solve second order cone
			 programs (SOCPs) through automatic detection of conic
			 constraints formulated as quadratic inequality
			 constraints.  Please see "exampleQCQP1.m" and
			 "exampleConic1.m" in "examples" for examples of using
			 this function.

knitro_qp.p              This function implements the Knitro-MATLAB API for
                         quadratic programs (QPs). This function supports both
			 convex and nonconvex QPs. Please see "exampleQP1.m" in
			 "examples" for an example of using this function.

knitro_solve.p           This function is an internal Knitro-MATLAB interface
                         file that should not be called directly.

knitro_options.p         This function is used by the Knitro-MATLAB interface
                         to set Knitro solver options.


Old Interface Files
-------------------

The following files were used prior to Knitro 12.1 to use the Knitro-MATLAB
interface.  They are still provided for backwards compatibility but may be
deprecated in a future release.  Please use the newer interface files
descibed above.  These files must be in the directory in which you run your
model (or some other special directory where MATLAB automatically searches for
files).

knitromatlab.m           This function implemented the Knitro-MATLAB API for
                         all continuous models (e.g. LP, QP, NLP) prior to
			 Knitro 12.1.

knitromatlab_mip.p       This function implemented the Knitro-MATLAB API for
                         models with integer or binary variables (e.g. MIP)
		         prior to Knitro 12.1.

knitromatlab_lsqnonlin.p This function implemented the Knitro-MATLAB API for
                         nonlinear least squares models prior to Knitro 12.1.

knitromatlab_fsolve.p    This function implemented the Knitro-MATLAB API for
                         nonlinear systems of equations prior to Knitro 12.1.


Test/Example Files
------------------

The files provided below are test examples provided in the "examples"
directory for testing the Knitro-Matlab interface.

exampleConic1.m       A MATLAB example code illustrating how to solve a
                      small model with a cone constraint using the
		      Knitro Mex interface.

exampleLP1.m          A MATLAB example code illustrating how to solve a
                      small linear programming (LP) model using the Knitro
                      Mex interface.

exampleLSQ1.m         A MATLAB example code illustrating how to solve a
                      small nonlinear least squares model using the
                      Knitro Mex interface.

exampleLSQ2.m         A MATLAB example code illustrating how to solve a
                      small nonlinear least squares model using the
                      Knitro Mex interface.

exampleMINLP1.m       A MATLAB example code illustrating how to solve a
                      small mixed-integer nonlinear model using the Knitro
                      Mex interface.

exampleMPEC1.m        A MATLAB example code illustrating how to solve a
                      small model with complementarity constraints using the
                      Knitro Mex interface.

exampleNLEQ1.m        A MATLAB example code illustrating how to solve a
                      nonlinear system of equations using the Knitro Mex
                      interface.

exampleNLP1.m         A MATLAB example code illustrating how to solve a
                      small nonlinear optimization model using the Knitro
                      Mex interface.

exampleNLP2.m         Same as exampleNLP1.m, but uses a Knitro options file
                      instead of a Knitro options structure to set Knitro
                      options.

exampleNLP3.m         An example showing how to automatically get the
                      Jacobian sparsity pattern for nonlinear constraints.

exampleNLPSymbolic.m  Same as exampleNLP1.m, but uses symbolic expressions
                      and computes derivatives using the Symbolic Math
		      Toolbox (required to run this example).

exampleQCQP1.m        A MATLAB example code illustrating how to solve a
                      small quadratically constrained quadratic programming
		      (QCQP) model using the Knitro Mex interface.

exampleQP1.m          A MATLAB example code illustrating how to solve a
                      small quadratic programming (QP) model using the Knitro
                      Mex interface.

nlp2options.opt       A sample Knitro input file of user options that are
                      used with the exampleNLP2.m test model.
                      Contents can be modified using any text-based editor. The
                      file can be passed as the last parameter to "knitro_nlp".

qpoptions.opt         A sample Knitro input file of user options that are
                      often ideal for quadratic programming (QP) models.
                      Contents can be modified using any text-based editor. The
                      file can be passed as the last parameter to "knitro_qp".

lpoptions.opt         A sample Knitro input file of user options that are
                      often ideal for linear programming (LP) models.
                      Contents can be modified using any text-based editor. The
                      file can be passed as the last parameter to "knitro_lp".

mipoptions.opt        A sample Knitro input file of user options that are
                      used with the exampleMINLP1.m test model.
                      Contents can be modified using any text-based editor. The
                      file can be passed as the last parameter to
		      "knitro_minlp".

knitro.opt            A sample Knitro input file of user options that details
                      all the Knitro options available.
