function [train, test]=vowel_data(vow_n)
    vowels; %running the vowels script to get the vowel codes
    n = find(vowel_code==vow_n); %returns the indexes for the vowel
    set = zeros(139, 14); %declaring an empty matrix to hold the values

    %fill set with all data for the given vowel
    for i = n(1):n(size(n,2))
        set(i-(n(1)-1),:) = alldata(i,:);
    end
    
    %splitting the data into a training and testing set
    train = set(1:70, :);
    test = set(71:139, :);
end
