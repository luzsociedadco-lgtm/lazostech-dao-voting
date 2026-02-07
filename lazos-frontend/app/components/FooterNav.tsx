"use client";
// Nota Importante: Las importaciones de 'next/link' y 'next/navigation' se han sustituido por 
// elementos estándar de React/HTML para permitir la compilación en este entorno de previsualización.

import { Home, Recycle, Ticket, User, LucideIcon } from "lucide-react";
import React, { useState } from 'react'; // Importamos useState para simular la ruta activa

// Definición de las propiedades de los elementos de navegación
interface NavItem {
  href: string;
  Icon: LucideIcon;
  label: string;
}

export default function FooterNav() {
  
  // **SIMULACIÓN**: En tu proyecto Next.js real, debes usar: const pathname = usePathname();
  // Usamos useState para simular que estamos en la ruta /perfil, manteniendo el estado activo.
  const [activePath] = useState('/perfil'); 

  // Función para verificar si una ruta está activa
  const isActive = (path: string) => activePath === path;

  // Clases Tailwind CSS
  const base = "flex flex-col items-center text-[11px] font-medium transition-colors duration-200";
  const iconBase = "w-6 h-6 mb-1 transition-colors duration-200";
  const activeColor = "text-blue-500";
  const inactiveColor = "text-white/80";

  // Array de elementos de navegación
  const navItems: NavItem[] = [
    { href: "/", Icon: Home, label: "Inicio" },
    { href: "/reciclaje", Icon: Recycle, label: "Reciclar" },
    { href: "/tickets", Icon: Ticket, label: "Tickets" },
    { href: "/dao", Icon: User, label: "DAO" },
  ];

  return (
    <nav className="fixed bottom-0 left-0 right-0 w-full bg-black border-t border-neutral-900 py-2 z-50">
      {/* Centramos el contenido de la nav dentro del ancho máximo de la aplicación */}
      <div className="flex justify-around items-center text-white max-w-md mx-auto h-16">
        
        {navItems.map(({ href, Icon, label }) => {
          const active = isActive(href);
          
          return (
            // USAMOS <a> en lugar de <Link> para evitar errores de compilación
            <a 
              key={href} 
              href={href} // En Next.js, esto sería el prop href del componente Link
              className={base}
            >
              <Icon
                className={`${iconBase} ${active ? activeColor : inactiveColor}`}
              />
              <span className={active ? activeColor : inactiveColor}>
                {label}
              </span>
            </a>
          );
        })}
      </div>
    </nav>
  ); 
}