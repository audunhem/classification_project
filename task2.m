training_data = [];
test_data = [];

for i = 1:12
    [train, test] = t(i);
    training_data(:,:,i) = train/3000;
    test_data(:,:,i) = test/3000;
end

GMM = cell(1,12);
M = 3;

for i = 1:12
    GMM{i} = fitgmdist(training_data(:,:,i),M,'Options',statset('MaxIter',1500,'TolFun',1e-50),'Regularize', 1e-10,'CovarianceType','diagonal','ProbabilityTolerance',1e-40,'Replicates',10);
    GMM{i}.NumIterations
end

errors_full = 0;
for i = 1:12
    confm_full(i,:) = classify_vocal_GMM(test_data(:,:,i),GMM);
    errors_full = errors_full + sum(confm_full(i,:))-confm_full(i,i);
end

error_rate_full = errors_full/(69*12)
    

function confm_row = classify_vocal_GMM(test_set,GMM)
    confm_row = zeros(12,1);
    for i = 1:69
        class = classify_sample_GMM(test_set(i,:),GMM);
        confm_row(class) = confm_row(class) + 1;
    end
end

function class = classify_sample_GMM(x,GMM)
    probabilities = zeros(1,12);
    for i = 1:12
        probabilities(i) = 0;
        for j = 1:GMM{i}.NumComponents
            probabilities(i) = probabilities(i) + GMM{i}.ComponentProportion(j)*mvnpdf(x,GMM{i}.mu(j,:),GMM{i}.Sigma(:,:,j));
        end
    end
    [~,class] = max(probabilities);
end








