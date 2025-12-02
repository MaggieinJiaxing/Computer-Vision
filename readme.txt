Overview
This is a MATLAB program for edge-driven level set image segmentation. By combining Poisson functions and local edge information, it achieves precise image segmentation.
**📌 Important note ** : This code base is directly related to The paper submitted to The Visual Computer journal.
If you use this code for research, please cite our papers (provide complete citation information after formal publication).

This project implements an Enhanced Active Contour Model (E-ACM), which integrates adaptive threshold selection, nonlinear Poisson equation edge enhancement and morphological optimization techniques, and is specifically designed to solve the problem of image segmentation in noisy environments. The algorithm demonstrates excellent robustness and accuracy in fields such as PCB component segmentation and non-uniform noise image processing.

Main functions
1. Use the improved level set method for image segmentation
2. Enhance edge detection by combining local edge information and Poisson functions
3. Achieve adaptive contour evolution through iterative optimization.

Environmental requirements
1. MATLAB R2018b or higher version
2. Image Processing Toolbox

Core parameters
c0: the initial level set constant
t: edge force symbol control 
alfa: the edge force intensity coefficient 
iterNum: the maximum number of iterations
k: average size of the K-filter kernel 
d: operation radius
T: Poisson function parameters

omga: edge enhancement coefficient
