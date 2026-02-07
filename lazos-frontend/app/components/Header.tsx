'use client'

import { useState } from 'react'
import { Menu, X } from 'lucide-react'

export default function Header() {
  const [open, setOpen] = useState(false)

  return (
    <header className="relative bg-[#b36a00] text-white flex flex-col shadow-md">
      {/* Fila superior con menú y logo */}
      <div className="flex items-center justify-between px-4 py-3">
        <button
          onClick={() => setOpen(!open)}
          className="p-2 rounded-md hover:bg-[#a45e00]/80 transition"
          aria-label="Abrir menú"
        >
          {open ? <X size={26} /> : <Menu size={26} />}
        </button>

        <h1 className="text-lg font-semibold tracking-wide">Lazos Wallet</h1>

        <div className="w-9 h-9 rounded-full bg-white/20 flex items-center justify-center border border-white/30">
          <span className="text-sm">👤</span>
        </div>
      </div>

      {/* Segunda fila: chips de Estudiante y Bono */}
      <div className="flex justify-center gap-3 pb-2">
        <div className="flex flex-col items-center bg-[#d32f2f] text-white rounded-xl px-3 py-1">
          <span className="text-sm font-semibold">✅ Estudiante</span>
          <span className="text-xs opacity-90">Pregrado</span>
        </div>
        <div className="flex flex-col items-center bg-[#1976d2] text-white rounded-xl px-3 py-1">
          <span className="text-sm font-semibold">✅ Bono</span>
          <span className="text-xs opacity-90">Almuerzo Regular</span>
        </div>
      </div>

      {/* Menú desplegable */}
      <div
        className={`absolute top-full left-0 w-full bg-[#b36a00] text-white shadow-lg overflow-hidden transition-all duration-300 z-50 ${
          open ? 'max-h-56 opacity-100' : 'max-h-0 opacity-0'
        }`}
      >
        <ul className="flex flex-col divide-y divide-white/20">
          <li className="p-3 hover:bg-[#c2880b] cursor-pointer">Inicio</li>
          <li className="p-3 hover:bg-[#c2880b] cursor-pointer">Mi Perfil</li>
          <li className="p-3 hover:bg-[#c2880b] cursor-pointer">Cerrar sesión</li>
        </ul>
      </div>
    </header>
  )
}