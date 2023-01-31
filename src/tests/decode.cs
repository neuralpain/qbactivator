//////// PowerShell ////////
// powershell -nop -c "$f=[IO.File]::ReadAllText($env:0) -split ':embdbin\:.*';iex($f[1]); X 1"
// :embdbin: // decode block
// Add-Type -Language CSharp -TypeDefinition @'
//////// PowerShell ////////

/*
  Decode embedded files
  https://github.com/AveYo/Compressed2TXT
  
  Encode with options below
    1. Input decoding key as password
    2. Randomize decoding key (use with 1)
    3. BAT85 encoder (+1.7% size of BAT91)
  Replace @param a85 with randomized key
*/

using System.IO;
public class BAT85 {
  public static void Decode(string tmp, string s) {
    MemoryStream ms = new MemoryStream(); n = 0;
    byte[] b85 = new byte[255]; string a85 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#$&()+,-./;=?@[]^_{|}~";
    int[] p85 = { 52200625, 614125, 7225, 85, 1 }; 
    for (byte i = 0; i < 85; i++) { b85[(byte)a85[i]] = i; }
    bool k = false; 
    int p = 0; 
    
    foreach (char c in s) {
      switch (c) { 
        case '\0': 
        case '\n': 
        case '\r': 
        case '\b': 
        case '\t': 
        case '\xA0': 
        case ' ': 
        case ':': k = false; break; 
        default: k = true; break; 
      }
      
      if (k) {
        n += b85[(byte)c] * p85[p++];
        if (p == 5) { ms.Write(n4b(), 0, 4); n = 0; p = 0; }
      }
    }

    if (p > 0) {
      for (int i = 0; i < 5 - p; i++) {
        n += 84 * p85[p + i];
      }
      ms.Write(n4b(), 0, p - 1);
    }

    File.WriteAllBytes(tmp, ms.ToArray()); ms.SetLength(0);
  }
  private static byte[] n4b() { return new byte[4] { (byte)(n >> 24), (byte)(n >> 16), (byte)(n >> 8), (byte)n }; }
  private static long n = 0;
}

//////// PowerShell ////////
// '@;
// function X([int]$r=1){ $tmp="$r._"; [BAT85]::Decode($tmp, $f[$r+1]); expand .\$tmp -F:* -R >$null 2>&1; del $tmp -force}
//////// PowerShell ////////
