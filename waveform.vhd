library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity waveform is
    Port ( position : in  STD_LOGIC;
           wave_bits_out : out  STD_LOGIC);
end waveform;

architecture Behavioral of waveform is
integer f, i, j, value;
begin



initial begin
	f = $fopen("waveforms/gmsk_level_0.txt", "r");
	--for(i = 0; i < rows; i = i + 1) begin
		--for(j = 0; j < columns; j = j + 1) begin
			$fscanf(f, "%h", value);
			data[bits * j +: bits] = value;
		--end
		#(1000000000 / samplerate);
	--end
	$fclose(f);
end



end Behavioral;

