import "./globals.css";
// RUTA CORREGIDA: Usamos './' porque 'components' está dentro de 'app'
import FooterNav from "./components/FooterNav"; 

export const metadata = {
  title: "Lazos App",
  description: "Dapp de reciclaje con tokens",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es">
      {/* Añadimos 'max-w-md' al body para simular el ancho de un dispositivo móvil y centrar el contenido, 
          lo cual es crucial para que el 'FooterNav' fijo se vea bien centrado. */}
      <body className="min-h-screen bg-neutral-100 mx-auto max-w-md pb-20 relative">

        {/* CONTENIDO DE LA PÁGINA */}
        {children}

        {/* FOOTER GLOBAL */}
        <FooterNav />
      </body>
    </html>
  );
}