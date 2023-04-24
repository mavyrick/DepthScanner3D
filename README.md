# DepthScanner3D

DepthScanner3D is an excellent example of how an iPhone's LiDAR device can produce 3D images. It works by collecting a grayscale depth image using LiDAR, the darker the shade the closer the portion of the image. The image is then processed into a 3D mesh by transforming the different shades of gray into the z-axis. The mesh can be rotated and scaled in the app using gestures. I believe that something like what is being done here can be used as a precursor to develop more elaborate 3D-scanned graphics.

The project was inspired by heightmaps (https://en.wikipedia.org/wiki/Heightmap). In fact, if you plug a heightmap into this project's system, it will have the same effect as the depth images.

The project will run on the following devices:

- iPhone 12 Pro or later

- iPad Pro 11-inch (3rd generation) or later

- iPad Pro 12.9-inch (5th generation) or later
