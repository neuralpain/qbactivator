using System.IO;

key = '.,;{-}[+](/)_|^=?O123456A789BCDEFGHYIeJKLMoN0PQRSTyUWXVZabcdfghijklmnpqrvstuwxz!@#$&~'; $chars = 85


public class BAT85
{
  public static void Enc(string fi, string fo, string key, int line)
  {
    byte[] a = File.ReadAllBytes(fi), b85 = new byte[85], q = new byte[5]; long n = 0; int p = 0, c = 0, v = 0, l = 0, z = a.Length;
    unchecked
    {
      while (c < 85) { b85[c] = (byte)key[c++]; }
      using (FileStream o = new FileStream(fo, FileMode.Append))
      {
        o.WriteByte(58); o.WriteByte(58);
        for (int i = 0; i != z; i++)
        {
          c = a[i];
          if (p == 3)
          {
            n | = (byte)c; v = 5; while (v > 0) { v--; q[v] = b85[(byte)(n % 85)]; n /= 85; }
            o.Write(q, 0, 5); n = 0; p = 0; l += 5;
            if (l > line) { l = 0; o.WriteByte(13); o.WriteByte(10); o.WriteByte(58); o.WriteByte(58); }
          }
          else
          {
            n | = (uint)(c << (24 - (p * 8))); p++;
          }
        }
        if (p > 0)
        {
          for (int i = p; i < 3 - p; i++) { n | = (uint)(0 << (24 - (p * 8))); }
          n | = 0; v = 5; while (v > 0) { v--; q[v] = b85[(byte)(n % 85)]; n /= 85; }
          o.Write(q, 0, p + 1);
        }
      }
    }
  }
}

public class BAT85
{
  public static void Dec(ref string[] f, int x, string fo, string key)
  {
    unchecked
    {
      byte[] b85 = new byte[256]; long n = 0; int p = 0, q = 0, c = 255, z = f[x].Length; while (c > 0) b85[c--] = 85; while (c < 85) b85[key[c]] = (byte)c++;
      int[] p85 = { 52200625, 614125, 7225, 85, 1 }; using (FileStream o = new FileStream(fo, FileMode.Create))
      {
        for (int i = 0; i != z; i++)
        {
          c = b85[f[x][i]]; if (c == 85) continue; n += c * p85[p++]; if (p == 5)
          {
            p = 0; q = 4; while (q > 0) { q--; o.WriteByte((byte)(n >> 8 * q)); }
            n = 0;
          }
        }
        if (p > 0) { for (int i = 0; i < 5 - p; i++) { n += 84 * p85[p + i]; } q = 4; while (q > (5 - p)) { o.WriteByte((byte)(n >> 8 * (--q))); } }
      }
    }
  }
}





public class BAT91
{
  public static void Enc(string fi, string fo, string key, int line)
  {
    byte[] a = File.ReadAllBytes(fi), b91 = new byte[91]; int n = 0, c = 0, v = 0, q = 0, l = 0, z = a.Length;
    while (c < 91) { b91[c] = (byte)key[c++]; }
    using (FileStream o = new FileStream(fo, FileMode.Append))
    {
      o.WriteByte(58); o.WriteByte(58);
      for (int i = 0; i != z; i++)
      {
        q | = (byte)a[i] << n; n += 8;
        if (n > 13)
        {
          v = q & 8191; if (v > 88) { q >>= 13; n -= 13; } else { v = q & 16383; q >>= 14; n -= 14; }
          o.WriteByte(b91[v % 91]); o.WriteByte(b91[v / 91]);
          l += 2; if (l > line) { l = 0; o.WriteByte(13); o.WriteByte(10); o.WriteByte(58); o.WriteByte(58); }
        }
      }
      if (n > 0) { o.WriteByte(b91[q % 91]); if (n > 7 || q > 90) { o.WriteByte(b91[q / 91]); } }
    }
  }
}

