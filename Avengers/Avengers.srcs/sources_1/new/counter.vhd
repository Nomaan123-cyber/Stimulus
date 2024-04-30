----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2023 19:52:01
-- Design Name: 
-- Module Name: counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
 port (
           Q:      out STD_LOGIC_VECTOR ( 3 downto 0 );
           SCLR:   in STD_LOGIC;
           CLK:    in STD_LOGIC
       );
end counter;

architecture Behavioral of counter is
signal count: std_logic_vector(0 to 3);
begin

  process(SCLR,clk)
   
      begin
        if (SCLR = '1') then count <= "0000";
        elsif (clk'event and clk = '1') then count <= count + 1;
        end if;
       end process;
       Q <= count;

end Behavioral;


