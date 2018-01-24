function [array3,C] = randomized_logistic_regression(array)

[m,n]=size(array);
k=10;
num_training=round(m*(0.75));
BT5=0;
l=1;
Lambda=0.00001;
%LOOCV loop

for i=1:m

%test set
test_set=array(i,:);

% training set

training_set=array;
training_set(i,:)=[];
BT3=0;

% Randomized Logistic Regression Loop

for j=1:k
 
BT=0;  
 
for num_random_set=1:200
 shuffled_set=training_set(randperm(m-1),:);
 new_training_set=shuffled_set(1:num_training,:);
      
 [B,S]=lasso(training_set(:,1:end-1),training_set(:,end),'Lambda',0.0001);
 B=(B~=0);
 BT=BT+B; 
 
 
 end
 
 BT2=(BT==200);
 
 BT3=BT3+BT2;
 
 
 
 % Determination of C parameter

C(l)=C_parameter_selection(training_set,BT2);
l=l+1;
 
 
end

BT4=(BT3==k);
BT5=BT4+BT5;

end

BT6=(BT5==m);
array3=[array(:,BT6) array(:,end)];


end

