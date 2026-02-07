"use client";

import React, { useState } from "react";
import { 
  Utensils, 
  Recycle, 
  Menu, 
  Check,
  Coins,
  PiggyBank
} from "lucide-react";

export default function WalletPage() {
  const [balance] = useState("1255");
  const [nudos] = useState("15");
  const [recycle] = useState("247");

  return (
    // Fondo principal color dorado/mostaza de la imagen
    <div className="min-h-screen bg-[#B47514] font-sans flex flex-col relative max-w-md mx-auto shadow-2xl overflow-hidden">
      
      {/* ====== HEADER SECTION ====== */}
      <div className="pb-4 relative z-10">
        
        {/* Navbar Superior */}
        <div className="px-6 pt-6 flex justify-between items-center text-white">
          <Menu className="w-8 h-8 cursor-pointer text-black/60" /> 
        </div>

        {/* ===== BADGES (Estudiante & Bono) ===== */}
        <div className="flex justify-between items-start px-4 mt-6 gap-3">
            <StatusBadge 
              label="Estudiante" 
              subLabel="Pregrado" 
              color="bg-[#D62417]" 
            />
            <StatusBadge 
              label="Bono" 
              subLabel="Almuerzo Regular" 
              color="bg-[#D62417]" 
            />
        </div>

        {/* ===== PERFIL + BALANCES ===== */}
        <div className="flex items-center px-5 mt-8">
          {/* Avatar con borde rojo (según imagen) */}
          <div className="relative">
            <img
              src="public/icons/profile.png"
              className="w-24 h-24 rounded-full border-4 border-[#D62417] object-cover shadow-md"
              alt="avatar"
            />
          </div>

          {/* Stats Text */}
          <div className="ml-4 flex-1 text-white">
            <div className="text-4xl font-extrabold tracking-tight">${balance}</div>
            <div className="text-xs font-bold text-black/40 tracking-widest mt-1 mb-2">TOKENS</div>
            
            <div className="flex gap-6">
              <div className="flex flex-col">
                <span className="text-2xl font-bold leading-none">{nudos}</span>
                <span className="text-[10px] text-white/90 font-bold tracking-wider mt-1">$NUDOS</span>
              </div>
              <div className="flex flex-col">
                <span className="text-2xl font-bold leading-none">{recycle}</span>
                <span className="text-[10px] text-white/90 font-bold tracking-wider mt-1">RECICLA</span>
              </div>
            </div>
          </div>
        </div>

        {/* ===== BARCODE SECTION ===== */}
        <div className="mt-6 px-5 relative">
          <p className="text-white font-bold text-sm mb-1 truncate tracking-wider">
            [Text Widget]
          </p>
          <p className="text-black/50 text-[10px] mb-1 font-mono">
             [Codigo] [Programa] [Correo] [Cedula]
          </p>
          
          <div className="flex items-center gap-2">
            {/* Barcode */}
            <div className="h-20 flex-1 bg-transparent flex items-center justify-start overflow-hidden">
               <div className="w-full h-full flex justify-between items-center gap-[1px]">
                  {[...Array(55)].map((_, i) => (
                    <div 
                      key={i} 
                      className={`h-full bg-black/80 ${Math.random() > 0.6 ? 'w-1.5' : 'w-[2px]'}`} 
                    />
                  ))}
               </div>
            </div>
            
            {/* Logo Rojo Circular a la derecha */}
            <div className="w-16 h-16 bg-[#D62417] rounded-full flex items-center justify-center border-4 border-white shadow-sm shrink-0">
               <div className="text-white font-bold text-2xl">L</div> 
            </div>
          </div>
          
          <p className="text-white text-xs mt-1 text-left opacity-90 pl-2">
            https://lazos.go/user
          </p>
        </div>
      </div>

      {/* ====== BOTTOM ACTION CARDS (GRID DE 4) ====== */}
      <div className="flex-1 bg-[#6D7072] pt-8 px-4 pb-12 mt-4 rounded-t-[30px] z-0 shadow-[0_-5px_15px_rgba(0,0,0,0.2)]">
        <div className="grid grid-cols-2 gap-4">
          
          {/* 1. TICKETS */}
          <ActionCard 
            icon={<Utensils className="w-8 h-8 text-[#D62417]" />}
            value="0"
            label="TICKETS"
            labelColor="text-[#D62417]/70"
          />

          {/* 2. RECICLAJE */}
          <ActionCard 
            icon={<Recycle className="w-8 h-8 text-green-600" />}
            value="56.4k"
            label="RECICLAJE"
            labelColor="text-green-600/70"
          />

          {/* 3. AHORRO */}
          <ActionCard 
            icon={<PiggyBank className="w-8 h-8 text-green-600" />}
            value="56.4k"
            label="AHORRO"
            labelColor="text-green-600/70"
          />

          {/* 4. $NUDOS */}
          <ActionCard 
            icon={<Coins className="w-8 h-8 text-green-600" />}
            value="15"
            label="$NUDOS"
            labelColor="text-green-600/70"
          />

        </div>
      </div>
      
    </div>
  );
}

// --- Componentes Auxiliares ---

function StatusBadge({ label, subLabel, color }) {
  return (
    <div className={`flex items-center gap-2 ${color} text-white px-3 py-3 rounded-lg shadow-sm flex-1`}>
      <div className="bg-white/20 p-0.5 rounded flex items-center justify-center shrink-0">
        <Check className="w-4 h-4 text-white" strokeWidth={4} />
      </div>
      <div className="flex flex-col leading-none overflow-hidden">
        <span className="font-bold text-sm truncate">{label}</span>
        <span className="text-[10px] opacity-90 mt-1 truncate">{subLabel}</span>
      </div>
    </div>
  );
}

function ActionCard({ icon, value, label, labelColor = "text-gray-400" }) {
  return (
    <div className="bg-white/90 backdrop-blur-sm rounded-3xl p-4 flex flex-col items-center justify-center shadow-lg h-36 w-full">
      <div className="mb-1 p-2 bg-gray-100 rounded-full">{icon}</div>
      <span className="text-3xl font-bold text-gray-800">{value}</span>
      <span className={`text-[10px] font-bold mt-1 tracking-widest uppercase ${labelColor}`}>{label}</span>
    </div>
  );
}