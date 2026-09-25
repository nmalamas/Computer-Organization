----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:42:36 04/06/2024 
-- Design Name: 
-- Module Name:    DECODER_5to32 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DECODER_5to32 is
    Port ( 
			  --Inputs--
			  Awr  : in  STD_LOGIC_VECTOR (4 downto 0);
           WrEn : in  STD_LOGIC;
			  
			  --Outputs--
			  Decoder5to32_Out : out STD_LOGIC_VECTOR (31 downto 0)
			  );
end DECODER_5to32;

architecture Behavioral of DECODER_5to32 is

begin
process(Awr,WrEn)
	begin
	 -- Implementation of a decoder as we know it,
	 -- only difference being the output in case of "00000" input.
	 -- In this case, the output is an array that has 0 in the
	 -- first position, so when later goes in the AND with WE
	 -- there is no case that the WrEn of the $0 is enabled.
	 if (WrEn ='1') then
         case Awr is
            when "00000" => 
                Decoder5to32_Out <= "00000000000000000000000000000000";
				when "00001" => 
                Decoder5to32_Out <= "00000000000000000000000000000010";
            when "00010" => 
                Decoder5to32_Out <= "00000000000000000000000000000100";
				when "00011" => 
                Decoder5to32_Out <= "00000000000000000000000000001000";
				when "00100" => 
                Decoder5to32_Out <= "00000000000000000000000000010000";
				when "00101" => 
                Decoder5to32_Out <= "00000000000000000000000000100000";
				when "00110" => 
                Decoder5to32_Out <= "00000000000000000000000001000000";
				when "00111" => 
                Decoder5to32_Out <= "00000000000000000000000010000000";
				when "01000" => 
                Decoder5to32_Out <= "00000000000000000000000100000000";
				when "01001" => 
                Decoder5to32_Out <= "00000000000000000000001000000000";
				when "01010" => 
                Decoder5to32_Out <= "00000000000000000000010000000000";
				when "01011" => 
                Decoder5to32_Out <= "00000000000000000000100000000000";
				when "01100" => 
                Decoder5to32_Out <= "00000000000000000001000000000000";
				when "01101" => 
                Decoder5to32_Out <= "00000000000000000010000000000000";
				when "01110" => 
                Decoder5to32_Out <= "00000000000000000100000000000000";
				when "01111" => 
                Decoder5to32_Out <= "00000000000000001000000000000000";
				when "10000" => 
                Decoder5to32_Out <= "00000000000000010000000000000000";
				when "10001" => 
                Decoder5to32_Out <= "00000000000000100000000000000000";
				when "10010" => 
                Decoder5to32_Out <= "00000000000001000000000000000000";
				when "10011" => 
                Decoder5to32_Out <= "00000000000010000000000000000000";
				when "10100" => 
                Decoder5to32_Out <= "00000000000100000000000000000000";
				when "10101" => 
                Decoder5to32_Out <= "00000000001000000000000000000000";
				when "10110" => 
                Decoder5to32_Out <= "00000000010000000000000000000000";
				when "10111" => 
                Decoder5to32_Out <= "00000000100000000000000000000000";
				when "11000" => 
                Decoder5to32_Out <= "00000001000000000000000000000000";
				when "11001" => 
                Decoder5to32_Out <= "00000010000000000000000000000000";
				when "11010" => 
                Decoder5to32_Out <= "00000100000000000000000000000000";
				when "11011" => 
                Decoder5to32_Out <= "00001000000000000000000000000000";
				when "11100" => 
                Decoder5to32_Out <= "00010000000000000000000000000000";
				when "11101" => 
                Decoder5to32_Out <= "00100000000000000000000000000000";
				when "11110" => 
                Decoder5to32_Out <= "01000000000000000000000000000000";
				when "11111" => 
                Decoder5to32_Out <= "10000000000000000000000000000000";
				when others =>
					 null;
			end case;
		else
			Decoder5to32_Out <= "00000000000000000000000000000000";
	end if;	
end process;

end Behavioral;