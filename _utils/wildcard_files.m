function fnames = wildcard_files(pattern)
    fnames = split(ls(pattern));
    fnames = fnames(~cellfun('isempty', fnames));
    fnames = sort(fnames);
end