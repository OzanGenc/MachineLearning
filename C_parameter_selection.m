%This function is called in randomized_logistic_regression.m function to select optimal regularization parameter C.
%You can change the values in C_parameter to try different regularization values.

function [C] = C_parameter_selection(training_set,BT2)

C_parameter=[0.001 0.01 1 10 100 1000];
C_parameter_length=length(C_parameter);
array=[training_set(:,BT2) training_set(:,end)];
[m,n]=size(array);
for  i=1:C_parameter_length
    
    
for j=1:m
    
test_subject=array(j,:);
training_set=array;
training_set(j,:)=[];

predictors=training_set(:,1:end-1);
response=training_set(:,end);


classificationSVM = fitcsvm(...
    predictors, ...
    response, ...
    'KernelFunction', 'linear', ...
    'PolynomialOrder', [], ...
    'KernelScale', 'auto', ...
    'BoxConstraint', C_parameter(i), ...
    'Standardize', true, ...
    'ClassNames', [1; 2]);
 

trainedClassifier.ClassificationSVM = classificationSVM;
svmPredictFcn = @(x) predict(classificationSVM, x);

validationPredictors = test_subject(1:end-1);
validationResponse(j) = test_subject(end);
[validationPrediction(j), validationScore] = svmPredictFcn(validationPredictors);




end


correctPredictions = (validationPrediction == validationResponse);
isMissing = isnan(validationResponse);
correctPredictions = correctPredictions(~isMissing);
validationAccuracy(i) = sum(correctPredictions)/length(correctPredictions);


end

[M I]=max(validationAccuracy);
C=C_parameter(I);
C=mode(C);
end

