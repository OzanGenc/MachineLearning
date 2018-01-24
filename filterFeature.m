%This function takes an array with that columns are features and rows are subjects. 
%Last column contains class labels. Function is suitable for two classes.
%This function eliminates statistically insignificant features by performing t-test.
%Bonferroni correction is made for multiple comparison.
%Output1 is an array that contains statistically significant features.The last column contains class labels.
%Output2 is indices of these features.

%CAUTION!!!
%

function [filtered_array,indices] = filterFeature(array)

cl=unique(array(:,end));

class1=array((find(array(:,end)==cl(1))),1:end-1);
class2=array((find(array(:,end)==cl(2))),1:end-1);
rho=0.05;
numfeature=size(class1,2);
h=zeros(numfeature,1);
rho_bonferroni_corrected=1-(1-rho)^(1/numfeature);


for i=1:numfeature
   h(i)=ttest2(class1(:,i),class2(:,i),rho_bonferroni_corrected);
end


indices=find(h==1);

filtered_array=array(:,indices);
filtered_array=[filtered_array,array(:,end)];

end







