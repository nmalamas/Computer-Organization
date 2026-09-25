----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:58:44 06/17/2024 
-- Design Name: 
-- Module Name:    HAZARD_DETECTION_UNIT - Behavioral 
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

entity HAZARD_DETECTION_UNIT is
    Port ( 
			  --Inputs--
			  frwrdA: in  STD_LOGIC_VECTOR (1 downto 0);
			  frwrdB: in  STD_LOGIC_VECTOR (1 downto 0);
			  is_previous_instr_load: in STD_LOGIC;
			  IF_DEC_rs : in  STD_LOGIC_VECTOR (4 downto 0);
           IF_DEC_rt : in  STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_rd : in  STD_LOGIC_VECTOR (4 downto 0);
           MEM_WrEn : in  STD_LOGIC;
			  
			  --Outputs--
			  pc_wren : out  STD_LOGIC;
			  if_dec_wren : out  STD_LOGIC;
           stall : out  STD_LOGIC);
end HAZARD_DETECTION_UNIT;

architecture Behavioral of HAZARD_DETECTION_UNIT is

begin
process(IF_DEC_rs,IF_DEC_rt,ID_EX_rd,MEM_WrEn,frwrdA,frwrdB,is_previous_instr_load)
	begin 
		if(                              
				 (MEM_WrEn = '0') 
		and ( (IF_DEC_rs = ID_EX_rd) or (IF_DEC_rt = ID_EX_rd) )
		and ( (IF_DEC_rs /= "00000") and (IF_DEC_rt /= "00000") ) 
		and ( (frwrdA = "00") and (frwrdB = "00") )
		and ( is_previous_instr_load = '1' )
		) then
			stall <= '1';
			pc_wren <= '0';
			if_dec_wren <= '0';
		else
			stall <= '0';
			pc_wren <= '1';
			if_dec_wren <= '1';
		end if;
	end process;
end Behavioral;

