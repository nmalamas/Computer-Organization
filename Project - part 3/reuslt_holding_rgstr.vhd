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

entity rt_rs_rd_address_holding_rgstr is
    Port ( 
			  --Inputs--
			  RST  : in  STD_LOGIC;
			  CLK  : in  STD_LOGIC;
           we   : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (14 downto 0);
			  
			  --Outputs--
			  Dout : out  STD_LOGIC_VECTOR (14 downto 0)
			  
			  -- ===== Indices in the output vector ===== --
			  -- RT --> 0 - 4
			  -- RS --> 5 - 9
			  -- RD --> 10 -14
			  -- ============================ --
		);
			  
end rt_rs_rd_holding_rgstr;

architecture Behavioral of rt_rs_rd_holding_rgstr is

signal new_data : std_logic_vector(14 downto 0);
signal curr_data : std_logic_vector(14 downto 0);
signal tmp_dout : std_logic_vector(14 downto 0);

begin
	PROCESS(clk,rst,we,data)
	BEGIN
	
		IF RST='1' THEN
			curr_data <= "000000000000000";
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
