----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2023 19:57:09
-- Design Name: 
-- Module Name: four_bit_comparator - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparator is
  port (
      a:      in std_logic_vector(3 downto 0);
      b:      in std_logic_vector(3 downto 0);
      gtoe:   out std_logic;
      clock:  in std_logic;
      pause:  in std_logic
  );
end comparator;

architecture Behavioral of four_bit_comparator is

begin

    process(clock, pause, a, b)
    begin
        if (pause='1') then
            gtoe <= '0';
        elsif (a >= b) then
            gtoe <= '1';
        else
            gtoe <= '0';
        end if;
  
    end process;

end Behavioral;
