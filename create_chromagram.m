function [chromagram, chroma_notes] = create_chromagram(log_freq_ps, t, pitch_rng, chroma)
chromagram = zeros(24,numel(t));
chroma_notes = string(zeros(24,1));

for note=1:12
    first_note = note:24:(pitch_rng(end)-note-30);
    second_note = (note+12):24:(pitch_rng(end)-note-30);
    chroma_notes([note,note+12]) = [strcat(chroma(note),"_1"), strcat(chroma(note),"_2")];
    chromagram(note,:) = sum(log_freq_ps(first_note,:),1);
    chromagram(note+12,:) = sum(log_freq_ps(second_note,:),1);
end

end