----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:54:25 04/05/2024 
-- Design Name: 
-- Module Name:    rgstr - Behavioral 
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

entity MEM_WB_CONTROL_REGISTER is
    Port ( 
			  --Inputs--
			  RST  : in  STD_LOGIC;
			  CLK  : in  STD_LOGIC;
           we   : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (1 downto 0);
           
			  --Outputs--
			  Dout : out  STD_LOGIC_VECTOR (1 downto 0)
			  
			  -- ===== Indices in the output vector ===== --
			  -- RF_WrEn           --> 0
			  -- RF_WrData_sel  --> 1
			  -- ============================ --
		);
			  
end MEM_WB_CONTROL_REGISTER;

architecture Behavioral of MEM_WB_CONTROL_REGISTER is

signal new_data : std_logic_vector(1 downto 0);
signal curr_data : std_logic_vector(1 downto 0);
signal tmp_dout : std_logic_vector(1 downto 0);

begin
	PROCESS(clk,rst,we,data)
	BEGIN
	
		IF RST='1' THEN
			curr_data <= "00";
			Dout <= curr_data;
		ELSE
			new_data <= Data;
			if rising_edge(clk) then
				IF we='1' THEN
					curr_data <= Data;
					Dout <= new_data;
				ELSE
					Dout <= curr_data;
				END IF;
			end if;
		END IF;				
	
	END PROCESS;
end Behavioral;
