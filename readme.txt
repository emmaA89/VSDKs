This software performs VSDK interpolation.
Variably Scaled Discontinuous Kernels (VSDKs) are suitable for
the reconstruction of discontinuous functions.
Authors:  S. De Marchi, F. Marchetti, E. Perracchione, 
          Universita' di Padova, 
          Dipartimento di Matematica "Tullio Levi-Civita".

Contacts:  demarchi@math.unipd.it; 
           francesco.marchetti.1@phd.unipd.it;
           emma.perracchione@math.unipd.it;

Last modified: 05/07/18

The script Demo.m provides an example for testing the software
For more details concerning input and output parameters and the usage of 
single functions, see the the corresponding Matlab functions.

The folder 'Functions' contains:

1. DistanceMatrix.m - Function which compute the distance matrix between two set of points
2. haltonseq.m - Function which compute Halton points
3. piecewise.m - Function which builds piecewise defined functions
4. vsdk_interp.m - Function which performs VSDK interpolation and presents the results

*** Remarks ***

- Function 1 is provided by the book "Meshfree Approximations Methods with Matlab", 
  Gregory E. Fasshauer, World Scientific, 2007.
- Function 2 is by Daniel Dougherty and can be found in the Matlab Central FileExchange.
- Function 3 is by Toby Driscoll and can be found in the Matlab Central FileExchange.
