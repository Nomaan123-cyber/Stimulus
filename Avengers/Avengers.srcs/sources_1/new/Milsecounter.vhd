----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2023 20:19:50
-- Design Name: 
-- Module Name: Milsecounter - Behavioral
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

entity Milsecounter is
 Port (clk_2 :in std_logic;
           clear_button : in std_logic;
           stop_button : in std_logic;
           f_state : in std_logic_vector(2 downto 0);
           one_mils : out integer;
           ten_mils : out integer;
           hundred_mils : out integer;
           one_sec : out integer;
           count_done : out std_logic
           );
end Milsecounter;

architecture Behavioral of Milsecounter is
begin
Milsecounter: process (clk_2, clear_button, stop_button, f_state)
variable one_millisecond : integer := 0;
variable ten_millisecond : integer := 0;
variable hundred_millisecond : integer := 0;
variable thousand_millisecond : integer := 0;
 begin
       if (clear_button='1') then 
           one_millisecond := 0;
           ten_millisecond := 0;
           hundred_millisecond := 0;
           thousand_millisecond := 0;
           one_mils <= 0;
           ten_mils <= 0;
           hundred_mils <= 0;
           one_sec <= 0;
           count_done <= '0';
       elsif rising_edge(clk_2) then
           if (f_state= "010") then
               if (stop_button='1') then   
                   count_done <= '1';   
               else                    
                   one_millisecond := one_millisecond + 1; 
                   if one_millisecond = 9 then    
                       ten_millisecond := ten_millisecond + 1;
                       one_millisecond := 0;
                       if ten_millisecond = 9 then   
                           hundred_millisecond := hundred_millisecond + 1;
                           ten_millisecond := 0;
                           if hundred_millisecond = 9 then 
                               thousand_millisecond := thousand_millisecond + 1;
                               hundred_millisecond := 0;
                               count_done <= '1';   
                           end if;
                       end if;
                   end if;
               end if;
           end if;
       end if;
       one_mils <= one_millisecond;
       ten_mils <= ten_millisecond;
       hundred_mils <= hundred_millisecond;
       one_sec <= thousand_millisecond;
   end process;


end Behavioral;
