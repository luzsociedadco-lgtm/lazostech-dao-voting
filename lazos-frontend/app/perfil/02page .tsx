"use client";

import React, { useState } from "react";
import { 
  Utensils, 
  Recycle, 
  Menu, 
  Check,
  Coins,
  DollarSign, // Usamos DollarSign para AHORRO
  Wallet, // Usamos Wallet para el ícono de Cartera/Perfil en el Footer
  Handshake, // Usamos Handshake para Lazos en el Footer
  Box, // Usamos Box como placeholder para 'Otros' en el Footer
  UtensilsCrossed // Ícono de comida más representativo para Tickets
} from "lucide-react";

// --- CONFIGURACIÓN DE COLORES ---
const PRIMARY_COLOR = "#91622C"; // Marrón-Dorado del header (Más cercano a la imagen final)
const BADGE_COLOR = "#D62417"; // Rojo intenso
const CARD_BG = "#e0e0e0"; // Gris claro para el contenedor de tarjetas
const ACTIVE_FOOTER_COLOR = "#3b82f6"; // Azul para el ítem activo del footer

// Componente para un Badge (Rectángulo Rojo con Check Azul)
function StatusBadge({ label, subLabel, color }) {
  return (
    <div className={`flex items-center gap-2 ${color} text-white px-3 py-2 rounded-lg shadow-sm flex-1 border border-red-800`}>
      {/* Checkmark cuadrado blanco con ícono azul */}
      <div className="w-4 h-4 bg-white flex items-center justify-center rounded-sm shrink-0">
        <Check className="w-3 h-3 text-blue-600" strokeWidth={4} />
      </div>
      <div className="flex flex-col leading-none overflow-hidden">
        <span className="font-bold text-sm truncate">{label}</span>
        <span className="text-[10px] opacity-90 truncate">{subLabel}</span>
      </div>
    </div>
  );
}

// Componente para una Métrica de Balance (TOKENS, $NUDOS, REICLA)
function BalanceMetric({ value, label }) {
    return (
        <div className="flex flex-col items-center text-center w-1/3">
            <span className="text-3xl font-extrabold tracking-tight leading-none">
                {label === "TOKENS" ? `$${value}` : value}
            </span>
            <span className="text-xs font-semibold opacity-90 tracking-widest mt-1">
                {label}
            </span>
        </div>
    );
}


// Componente para una Ficha de Acción (Bottom Card)
function ActionCard({ icon, value, label, valueColor, labelColor }) {
  return (
    <div className="bg-white rounded-xl p-4 flex flex-col items-center justify-center shadow-lg h-36 w-full">
      {/* Ícono */}
      <div className="mb-1 p-2">{React.cloneElement(icon, { className: `w-8 h-8 mx-auto mb-2 ${valueColor}` })}</div>
      
      {/* Valor */}
      <span className={`text-3xl font-bold ${valueColor}`}>{value}</span>
      
      {/* Etiqueta */}
      <span className={`text-xs font-semibold mt-1 uppercase ${labelColor}`}>{label}</span>
    </div>
  );
}

// Componente Footer de Navegación
const FooterNav = () => {
    // Definimos la estructura del menú (usando los íconos de la imagen final)
    const navItems = [
        { icon: Wallet, label: "Cartera", active: true }, // Azul
        { icon: UtensilsCrossed, label: "Tickets", active: false }, // Blanco (Icono de casa/comida)
        { icon: Recycle, label: "Reciclaje", active: false }, // Blanco
        { icon: Handshake, label: "Lazos", active: false }, // Blanco
        { icon: Box, label: "Otros", active: false }, // Blanco (Usamos Box para simular el ícono de buzón/descarga)
    ];

    return (
        // Fijo en la parte inferior, color negro
        <div className="fixed bottom-0 left-0 right-0 z-50 bg-black text-white h-16 shadow-2xl max-w-md mx-auto">
            <div className="flex justify-around items-center h-full">
                {navItems.map((item, index) => (
                    <button 
                        key={index} 
                        className={`flex flex-col items-center text-xs pt-1 transition duration-200 
                                    ${item.active ? 'text-blue-500 font-bold' : 'text-white/80 hover:text-white'}`}
                    >
                        {/* El ícono de Tickets necesita un wrapper de 'casa' como en la imagen */}
                        {item.label === 'Tickets' ? (
                            <div className={`p-1 rounded-lg ${item.active ? 'bg-transparent' : 'bg-white'}`}>
                                <UtensilsCrossed className="w-6 h-6" style={{ color: item.active ? ACTIVE_FOOTER_COLOR : BADGE_COLOR }} />
                            </div>
                        ) : (
                            // Otros íconos
                            <item.icon className="w-6 h-6" style={{ color: item.active ? ACTIVE_FOOTER_COLOR : 'white' }} />
                        )}
                        <span className="mt-1">{item.label}</span>
                    </button>
                ))}
            </div>
        </div>
    );
};


export default function WalletPage() {
  const [balance] = useState("1255");
  const [nudos] = useState("15");
  const [recycle] = useState("247");
  const [ahorro] = useState("56.4k"); 
  const [reciclaje] = useState("56.4k"); // El valor de reciclaje aquí es el de la ficha, no el del header

  return (
    // Fondo principal color marrón/dorado con espacio abajo para el footer
    <div className={`min-h-screen bg-[${PRIMARY_COLOR}] font-sans flex flex-col relative max-w-md mx-auto shadow-2xl overflow-hidden pb-16`}>
      
      {/* ====== HEADER SECTION (Marrón/Dorado) ====== */}
      <div className="pb-4 relative z-10 rounded-b-[45px] overflow-hidden">
        
        {/* Navbar Superior */}
        <div className="px-6 pt-6 flex justify-between items-center text-white">
          <Menu className="w-8 h-8 cursor-pointer text-white" /> 
        </div>

        {/* ===== BADGES (Estudiante & Bono) ===== */}
        <div className="flex justify-between items-start px-4 mt-4 gap-3">
            <StatusBadge 
              label="Estudiante" 
              subLabel="Pregrado" 
              color={`bg-[${BADGE_COLOR}]`} 
            />
            <StatusBadge 
              label="Bono" 
              subLabel="Almuerzo Regular" 
              color={`bg-[${BADGE_COLOR}]`} 
            />
        </div>

        {/* ===== PERFIL + BALANCES (Grid 4 columnas para mejor alineación) ===== */}
        <div className="grid grid-cols-4 items-center gap-4 px-5 mt-4">
          
          {/* Columna 1: AVATAR (Ocupa 1/4) */}
          <div className="col-span-1 flex justify-start">
            <img
              src="https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80"
              className={`w-[75px] h-[75px] rounded-full border-4 border-[${BADGE_COLOR}] object-cover shadow-md`}
              alt="avatar"
            />
          </div>

          {/* Columnas 2, 3, 4: BALANCES (Ocupan 3/4) */}
          <div className="col-span-3 flex justify-between items-end text-white">
            <BalanceMetric value={balance} label="TOKENS" />
            <BalanceMetric value={nudos} label="$NUDOS" />
            <BalanceMetric value={recycle} label="REICLA" />
          </div>
        </div>


        {/* ===== BARCODE SECTION (Tarjeta Blanca Flotante) ===== */}
        <div className="mt-4 px-5 pb-8">
            <div className="bg-white rounded-xl shadow-2xl p-3 relative">
                
                {/* Contenedor de elementos internos (Widget, Barcode, Scanner) */}
                <div className="flex items-center justify-between h-20">
                    
                    {/* 1. Text Widget Box (Izquierda) */}
                    <div className="text-left text-sm text-gray-800 font-mono leading-tight w-2/5 p-1">
                        <p className="font-bold text-xs">[Text Widget]</p>
                        <div className="text-[10px] opacity-90 mt-1">
                            <p>[Código] [Programa]</p>
                            <p>[Cédula]</p>
                        </div>
                    </div>
                    
                    {/* 2. Barcode (Centro) */}
                    <div className="flex-1 flex flex-col justify-center items-center h-full relative mx-2">
                        {/* Simulación de código de barras - Placeholder */}
                        <div className="w-full h-12 bg-white overflow-hidden rounded-md border border-gray-300 flex justify-center">
                            {/* Líneas de código de barras */}
                             {[...Array(15)].map((_, i) => (
                                 <div key={i} className={`h-full inline-block ${i % 3 === 0 ? 'w-2 bg-black' : 'w-1 bg-black'} mx-[0.5px]`}></div>
                            ))}
                        </div>
                    </div>
                    
                    {/* 3. Scanner/Notificación (Derecha - Círculo rojo de UV) */}
                    <div className="w-12 h-12 bg-red-600 rounded-full flex items-center justify-center border-4 border-white shadow-xl">
                        {/* Ícono simple para simular el escáner UV */}
                        <svg className="w-6 h-6 text-white" viewBox="0 0 24 24" fill="currentColor">
                           <path d="M15 11l-3 3m0 0l-3-3m3 3V8m0 0H8a4 4 0 00-4 4v4a4 4 0 004 4h8a4 4 0 004-4v-4a4 4 0 00-4-4h-4z" />
                        </svg>
                    </div>
                </div>
                
                {/* URL del usuario centrada, justo debajo del contenedor blanco */}
                <p className="text-xs mt-2 opacity-90 text-center text-gray-600">https://lazos.go/user</p>
            </div>
        </div>
      </div>

      {/* ====== BOTTOM ACTION CARDS (Contenedor Gris Flotante) ====== */}
      <div className={`flex-1 bg-[${CARD_BG}] pt-8 px-4 pb-4 mt-[-20px] rounded-t-[30px] z-0 shadow-[0_-5px_15px_rgba(0,0,0,0.2)] border border-gray-300`}>
        <div className="grid grid-cols-2 gap-4">
          
          {/* 1. TICKETS (Ícono Rojo) */}
          <ActionCard 
            icon={<UtensilsCrossed />}
            value="0"
            label="TICKETS"
            valueColor="text-[#D62417]"
            labelColor="text-neutral-600"
          />

          {/* 2. RECICLAJE (Ícono Verde) */}
          <ActionCard 
            icon={<Recycle />}
            value={reciclaje}
            label="RECICLAJE"
            valueColor="text-green-500"
            labelColor="text-neutral-600"
          />

          {/* 3. AHORRO (Ícono Verde de Dólar) */}
          <ActionCard 
            icon={<DollarSign />}
            value={ahorro}
            label="AHORRO"
            valueColor="text-green-600"
            labelColor="text-neutral-600"
          />

          {/* 4. $NUDOS (Ícono Azul de Monedas) */}
          <ActionCard 
            icon={<Coins />}
            value={nudos}
            label="$NUDOS"
            valueColor="text-blue-600"
            labelColor="text-neutral-600"
          />

        </div>
      </div>
      
      {/* ====== FOOTER NAVIGATION (Siempre al final) ====== */}
      <FooterNav />
    </div>
  );
}