function oligos = generate_oligo_file_RNA_DNA(inseq,oligolen,currmatches,probename,outoligofile)

for i = 1:length(currmatches)
    theseq = inseq(currmatches(i):(currmatches(i)+oligolen-1));
    seq = revcomp(inseq(currmatches(i):(currmatches(i)+oligolen-1)));
    oligos(i).seq = seq;
    
    oligos(i).gc = getGC(seq);
    oligos(i).Tm = getTm_RNA_DNA(theseq);
    oligos(i).Gibbs = getGibbs_RNA_DNA(theseq);
    oligos(i).probename = [probename '_' num2str(i)];
    
end;


% fid = fopen(outoligofile,'w');
% for i = 1:length(oligos)
%   fprintf(fid,'%d,%d,%2.1f,%s,%s\n',i,round(oligos(i).gc),oligos(i).Tm,oligos(i).seq,oligos(i).probename);
% end;
% fclose(fid);

% Write out in a TSV
fid = fopen([outoligofile],'w');
for i = 1:length(oligos)
  fprintf(fid,'%d\t%d\t%2.1f\t%2.1f\t%s\t%s\n',i,round(oligos(i).gc),oligos(i).Tm,oligos(i).Gibbs,oligos(i).seq,oligos(i).probename);
end;
fclose(fid);
