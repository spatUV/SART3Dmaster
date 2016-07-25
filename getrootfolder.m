function rootfolder = getrootfolder();

    rootfolder = which('SART3Dini');
    rootfolder = rootfolder(1:end-12);

end
