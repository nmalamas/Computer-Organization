----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:11:38 04/07/2024 
-- Design Name: 
-- Module Name:    DATA_MEM - Behavioral 
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

entity DATA_MEM is
    Port ( 
			  -- Inputs--
			  CLK : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           isLoadByte : in  STD_LOGIC;
			  
			  -- Outputs --
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end DATA_MEM;

architecture Behavioral of DATA_MEM is

-- SIGNALS
signal ALU_Addr_bits : std_logic_vector(11 downto 0);
signal Data_out : std_logic_vector(31 downto 0);

-- MEM Component
component MEM is
  port (
    a : in std_logic_vector(9 downto 0);
    d : in std_logic_vector(31 downto 0);
    clk : in std_logic;
    we : in std_logic;
    qspo : out std_logic_vector(31 downto 0)
  );
end component;

begin
	dataMem : MEM
		port map(
			clk => CLK,
			we  => Mem_WrEn,
			a   => ALU_Addr_bits(11 downto 2),
			d   => MEM_DataIn,
			qspo => Data_out
		);
	
process(clk)
begin
		-- By default, the IP Core generated memory is of ReadFirst type,
		-- meaning that, in case of Mem_WrEn=1, half of the clock period
		-- is dedicated to outputing the data in the address given by ALU_MEM_Addr,
		-- and the other half of it to writing the new data coming from
		-- MEM_DataIn.
		-- In case of Mem_WrEn=0, the memory obviously outputs the data
		-- existing in the address given by ALU_MEM_Addr.
		
		if isLoadByte = '1' then
			ALU_Addr_bits <= ALU_MEM_Addr(11 downto 0);
			if ALU_Addr_bits(1 downto 0) = "00" then
				MEM_DataOut <= "000000000000000000000000" & Data_out(7 downto 0);
			elsif ALU_Addr_bits(1 downto 0) = "01" then
				MEM_DataOut <= "000000000000000000000000" & Data_out(15 downto 8);
			elsif ALU_Addr_bits(1 downto 0) = "10" then
				MEM_DataOut <= "000000000000000000000000" & Data_out(23 downto 16);
			elsif ALU_Addr_bits(1 downto 0) = "11" then
				MEM_DataOut <= "000000000000000000000000" & Data_out(31 downto 24);
			end if;
		elsif isLoadByte = '0' then
			MEM_DataOut <= Data_out;
		end if;
			
	end process;
end Behavioral;

