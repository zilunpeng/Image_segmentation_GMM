# Image Segmentation by using GMM

In this project, I practiced using Gaussian Mixture Model to segment images. EM algorithm is used for optimization. 

Here are some results

<p align="center">
  <img src="imgs/69020.jpg">
</p>

<p align="center">
  <img width=300 src="imgs/69020_seg.png">
</p>

<p align="center">
  <img width=300 src="imgs/69020_seg_8.png">
</p>

<p align="center">
  <img src="imgs/227092.jpg">
</p>

<p align="center">
  <img width=300 src="imgs/227092_seg.png">
</p>

To use GMM for this task, we have to specify the number of clusters that we want in our segmentation. This is not ideal in many situations, however, we can use cross validation to decide the number of clusters. See ```assignment2_part2.m``` for the cross validation code.
