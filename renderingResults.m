clear all
close all
clc

load('.\data\results\5274.mat')
load 01_MorphableModel.mat
ndims = 40;
FV.faces = tl;

testdir='.\data\uniqueImages2\';
im = imread(strcat(testdir,'5274.jpg'));


disp('Rendering final results...');
FV.vertices=reshape(shapePC(:,1:ndims)*b+shapeMU,3,size(shapePC,1)/3)';
figure; subplot(1,3,1); patch(FV, 'FaceColor', [1 1 1], 'EdgeColor', 'none', 'FaceLighting', 'phong'); light; axis equal; axis off;
subplot(1,3,2); imshow(renderFace(FV,im,R,t,s,false));
subplot(1,3,3); imshow(renderFace(FV,im,R,t,s,true));