library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package music_pkg is
    
    constant CLK_FREQ : integer := 50000000; -- Clock board (misal 50MHz)
    
    -- Definisi Microinstruction Opcodes
    constant OP_PLAY : std_logic_vector(1 downto 0) := "00"; 
    constant OP_WAIT : std_logic_vector(1 downto 0) := "01"; 
    constant OP_STOP : std_logic_vector(1 downto 0) := "10"; 
    constant OP_LOOP : std_logic_vector(1 downto 0) := "11"; 
    
    -- Konstanta Frekuensi Nada (Contoh menggunakan C4 sebagai Do)
    -- Format: Hz (Hertz)
    constant NOTE_C4_HZ : integer := 262; -- Do
    constant NOTE_D4_HZ : integer := 294; -- Re
    constant NOTE_E4_HZ : integer := 330; -- Mi
    constant NOTE_F4_HZ : integer := 349; -- Fa
    constant NOTE_G4_HZ : integer := 392; -- Sol
    constant NOTE_A4_HZ : integer := 440; -- La
    constant NOTE_B4_HZ : integer := 494; -- Si
    
    -- Durasi WAIT (dalam puluhan ms, contoh: 500 = 500ms)
    constant WAIT_HALF_SEC : integer := 500;
    
    -- Fungsi untuk menghitung Divisor
    function calc_divisor(freq : integer) return integer;

end music_pkg;

package body music_pkg is
    function calc_divisor(freq : integer) return integer is
    begin
        -- Divisor = CLK_FREQ / (2 * freq)
        if freq = 0 then
            return 0; -- Diam
        else
            return (CLK_FREQ / (2 * freq));
        end if;
    end calc_divisor;
end music_pkg;