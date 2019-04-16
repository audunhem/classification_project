%This code i copied from the provided file: "Hildebrand_vowel.pdf".
%It provides matrices from the text file data, and matches it to vowels. 

[files,dur,F0s,F1s,F2s,F3s,F4s,F120,F220,F320,F150,F250,F350,F180,F280,F380] = textread('vowdata_no_header.txt','%s%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f%4.1f');

% character 1: m=man, w=woman, b=boy, g=girl
% characters 2-3: talker number
% characters 4-5: vowel (ae="had", ah="hod", aw="hawed", eh="head",
% er="heard", ei="haid", ih="hid", iy="heed", oa=/o/ as in âboat",
% oo="hood", uh="hud", uw="who'd")

vowel = str2mat('ae','ah','aw','eh','er','ei','ih','iy','oa','oo','uh','uw');
talker_group = str2mat('m','w','b','g');
files=char(files); % convert cell array to character matrix
[nfiles,nchar]=size(files);

for ifile=1:nfiles
    vowel_code(ifile) = strmatch(files(ifile,4:5),vowel);
    talker_group_code(ifile) = strmatch(files(ifile,1),talker_group);
    talker_number(ifile) = str2num(files(ifile,2:3));
end

alldata = [F0s,F1s,F2s,F3s,F4s,F120,F220,F320,F150,F250,F350,F180,F280,F380];



