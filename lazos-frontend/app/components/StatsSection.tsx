'use client'

import { Ticket, Recycle, PiggyBank, Wallet } from 'lucide-react'

export default function StatsSection() {
  return (
    <section className="grid grid-cols-2 gap-3 px-6 mt-5">
      
      {/* 🧾 Tickets */}
      <div className="bg-gray-100 rounded-2xl shadow-md p-4 flex flex-col items-center justify-center text-black">
        <div className="bg-red-600 text-white p-2 rounded-full mb-2">
          <Ticket className="w-5 h-5" />
        </div>
        <p className="text-lg font-semibold">0</p>
        <p className="text-xs font-bold text-gray-700">TICKETS</p>
      </div>

      {/* ♻️ Recicla */}
      <div className="bg-gray-100 rounded-2xl shadow-md p-4 flex flex-col items-center justify-center text-black">
        <div className="bg-green-600 text-white p-2 rounded-full mb-2">
          <Recycle className="w-5 h-5" />
        </div>
        <p className="text-lg font-semibold">56.4k</p>
        <p className="text-xs font-bold text-gray-700">RECICLAJE</p>
      </div>

      {/* 💰 Ahorro */}
      <div className="bg-gray-100 rounded-2xl shadow-md p-4 flex flex-col items-center justify-center text-black">
        <div className="bg-yellow-500 text-white p-2 rounded-full mb-2">
          <PiggyBank className="w-5 h-5" />
        </div>
        <p className="text-lg font-semibold">56.4k</p>
        <p className="text-xs font-bold text-gray-700">AHORRO</p>
      </div>

      {/* 🪙 $NUDOS */}
      <div className="bg-gray-100 rounded-2xl shadow-md p-4 flex flex-col items-center justify-center text-black">
        <div className="bg-blue-600 text-white p-2 rounded-full mb-2">
          <Wallet className="w-5 h-5" />
        </div>
        <p className="text-lg font-semibold">15</p>
        <p className="text-xs font-bold text-gray-700">$NUDOS</p>
      </div>

    </section>
  )
}