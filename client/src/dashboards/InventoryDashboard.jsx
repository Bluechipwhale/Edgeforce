import React, { useState, useEffect } from 'react';
import {
  Package,
  Boxes,
  ArrowDownRight,
  ArrowUpRight,
  RefreshCw,
  Plus,
  AlertTriangle,
  Search,
  Filter,
  Warehouse,
  CheckCircle2,
  X,
  Edit3,
  ClipboardList,
  UserCheck,
  Truck,
  FileText
} from 'lucide-react';
import { api } from '../lib/api';

export default function InventoryDashboard({ user }) {
  const [loading, setLoading] = useState(true);
  const [products, setProducts] = useState([]);
  const [movements, setMovements] = useState([]);
  const [warehouses, setWarehouses] = useState([]);
  const [summary, setSummary] = useState({ totalSKUs: 0, totalQuantity: 0, totalValuation: 0, lowStockCount: 0 });

  // Filters & State
  const [search, setSearch] = useState('');
  const [categoryFilter, setCategoryFilter] = useState('all');
  const [lowStockOnly, setLowStockOnly] = useState(false);
  const [activeTab, setActiveTab] = useState('stock'); // stock, movements, warehouses, collected

  // 1. Add Product Modal State
  const [addProductModalOpen, setAddProductModalOpen] = useState(false);
  const [productForm, setProductForm] = useState({
    name: '',
    sku: '',
    category: 'Packaged Food & Beverages',
    unit: 'carton',
    price: '',
    cost_price: '',
    stock_quantity: 50,
    reorder_level: 20,
    warehouse_name: 'Ikeja Central Depot',
    shelve_location: 'Aisle 1 - Bay A (Rack 1)'
  });
  const [submittingProduct, setSubmittingProduct] = useState(false);

  // 2. Edit Shelve Location Modal State
  const [shelfModalOpen, setShelfModalOpen] = useState(false);
  const [editingProduct, setEditingProduct] = useState(null);
  const [shelfLocationInput, setShelfLocationInput] = useState('');
  const [submittingShelf, setSubmittingShelf] = useState(false);

  // 3. Record Item Collection / Sign-Out Modal State
  const [collectionModalOpen, setCollectionModalOpen] = useState(false);
  const [collectionForm, setCollectionForm] = useState({
    product_id: '',
    warehouse_id: 1,
    quantity: 1,
    collector_name: '',
    collector_phone: '',
    collector_department: 'Commercial Sales Operations',
    waybill_number: '',
    purpose: 'Direct Customer Order Pick-up',
    notes: ''
  });
  const [submittingCollection, setSubmittingCollection] = useState(false);

  // 4. Restock / Movement Modal State
  const [movementModalOpen, setMovementModalOpen] = useState(false);
  const [selectedProduct, setSelectedProduct] = useState(null);
  const [movementForm, setMovementForm] = useState({
    movement_type: 'RESTOCK',
    warehouse_id: 1,
    quantity: 10,
    reference_number: '',
    notes: ''
  });
  const [submittingMovement, setSubmittingMovement] = useState(false);

  const loadInventory = async () => {
    setLoading(true);
    try {
      const [prodRes, movRes, whRes, sumRes] = await Promise.all([
        api.get('/inventory/products'),
        api.get('/inventory/movements'),
        api.get('/inventory/warehouses'),
        api.get('/inventory/summary')
      ]);

      const prods = prodRes?.data || prodRes || [];
      setProducts(prods);
      setMovements(movRes?.data || movRes || []);
      setWarehouses(whRes?.data || whRes || []);
      if (sumRes?.data || sumRes) {
        setSummary(sumRes?.data || sumRes);
      }
      if (prods.length > 0 && !collectionForm.product_id) {
        setCollectionForm(prev => ({ ...prev, product_id: prods[0].id }));
      }
    } catch (err) {
      console.error('Failed to load inventory:', err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadInventory();
  }, []);

  // Handle Add New Product
  const handleCreateProduct = async (e) => {
    e.preventDefault();
    if (!productForm.name || !productForm.price) {
      alert('Product Name and Unit Price are required.');
      return;
    }
    setSubmittingProduct(true);
    try {
      await api.post('/inventory/products', {
        ...productForm,
        price: Number(productForm.price),
        cost_price: Number(productForm.cost_price || productForm.price * 0.8),
        stock_quantity: Number(productForm.stock_quantity || 0),
        reorder_level: Number(productForm.reorder_level || 20)
      });
      setAddProductModalOpen(false);
      setProductForm({
        name: '',
        sku: '',
        category: 'Packaged Food & Beverages',
        unit: 'carton',
        price: '',
        cost_price: '',
        stock_quantity: 50,
        reorder_level: 20,
        warehouse_name: 'Ikeja Central Depot',
        shelve_location: 'Aisle 1 - Bay A (Rack 1)'
      });
      loadInventory();
    } catch (err) {
      alert(err.message || 'Failed to create product');
    } finally {
      setSubmittingProduct(false);
    }
  };

  // Handle Update Shelf Location
  const handleSaveShelfLocation = async (e) => {
    e.preventDefault();
    if (!editingProduct) return;
    setSubmittingShelf(true);
    try {
      await api.put(`/inventory/products/${editingProduct.id}`, {
        shelve_location: shelfLocationInput
      });
      setShelfModalOpen(false);
      setEditingProduct(null);
      loadInventory();
    } catch (err) {
      alert(err.message || 'Failed to update shelve location');
    } finally {
      setSubmittingShelf(false);
    }
  };

  // Handle Record Item Collection
  const handleRecordCollection = async (e) => {
    e.preventDefault();
    if (!collectionForm.product_id || !collectionForm.collector_name) {
      alert('Product and Collector Name are required.');
      return;
    }
    setSubmittingCollection(true);
    try {
      const prod = products.find(p => String(p.id) === String(collectionForm.product_id));
      const refNum = collectionForm.waybill_number || `COLLECT-${Date.now().toString().slice(-5)}`;
      const noteDetails = `Item Collected By: ${collectionForm.collector_name} (${collectionForm.collector_department || 'Customer'}) | Phone: ${collectionForm.collector_phone || 'N/A'} | Purpose: ${collectionForm.purpose} | Notes: ${collectionForm.notes || 'Goods released from depot.'}`;

      await api.post('/inventory/movements', {
        product_id: Number(collectionForm.product_id),
        warehouse_id: Number(collectionForm.warehouse_id),
        movement_type: 'DISPATCH',
        quantity: Number(collectionForm.quantity),
        reference_number: refNum,
        notes: noteDetails
      });

      setCollectionModalOpen(false);
      setCollectionForm({
        product_id: products[0]?.id || '',
        warehouse_id: 1,
        quantity: 1,
        collector_name: '',
        collector_phone: '',
        collector_department: 'Commercial Sales Operations',
        waybill_number: '',
        purpose: 'Direct Customer Order Pick-up',
        notes: ''
      });
      loadInventory();
      setActiveTab('collected');
    } catch (err) {
      alert(err.message || 'Failed to record item collection');
    } finally {
      setSubmittingCollection(false);
    }
  };

  const handleRecordMovement = async (e) => {
    e.preventDefault();
    if (!selectedProduct) return;
    setSubmittingMovement(true);
    try {
      await api.post('/inventory/movements', {
        product_id: selectedProduct.id,
        warehouse_id: movementForm.warehouse_id,
        movement_type: movementForm.movement_type,
        quantity: Number(movementForm.quantity),
        reference_number: movementForm.reference_number || `RESTOCK-${Date.now().toString().slice(-4)}`,
        notes: movementForm.notes
      });
      setMovementModalOpen(false);
      loadInventory();
    } catch (err) {
      alert(err.message || 'Failed to record stock movement');
    } finally {
      setSubmittingMovement(false);
    }
  };

  const categories = ['all', ...new Set(products.map(p => p.category))];

  const filteredProducts = products.filter(p => {
    const matchSearch = !search ||
      p.name.toLowerCase().includes(search.toLowerCase()) ||
      p.sku.toLowerCase().includes(search.toLowerCase());
    const matchCat = categoryFilter === 'all' || p.category === categoryFilter;
    const matchLow = !lowStockOnly || (p.stock_quantity <= (p.reorder_level || 20));
    return matchSearch && matchCat && matchLow;
  });

  const collectedMovements = movements.filter(m => m.movement_type === 'DISPATCH' || (m.notes && m.notes.toLowerCase().includes('collected')));

  return (
    <div className="p-4 lg:p-8 max-w-7xl mx-auto space-y-6 animate-in fade-in duration-200">
      {/* Top Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
          <div className="flex items-center gap-2">
            <span className="px-2.5 py-0.5 rounded-full text-[10px] font-black uppercase tracking-wider bg-orange-500/10 text-orange-600 dark:text-orange-400 border border-orange-500/20">
              Supply Chain & Logistics
            </span>
          </div>
          <h1 className="text-2xl lg:text-3xl font-black text-zinc-900 dark:text-zinc-100 mt-1">
            Inventory & Warehouses
          </h1>
          <p className="text-xs text-zinc-500 dark:text-zinc-400 mt-0.5">
            Monitor real-time SKU stock levels, regional fulfillment depots, item collections, and supply movements.
          </p>
        </div>

        {/* Global Action Triggers */}
        <div className="flex flex-wrap items-center gap-2">
          <button
            onClick={() => setAddProductModalOpen(true)}
            className="px-4 py-2 bg-orange-500 hover:bg-orange-600 text-white rounded-xl text-xs font-bold flex items-center gap-1.5 shadow-xs transition"
          >
            <Plus size={15} /> + Add Item / Product
          </button>

          <button
            onClick={() => setCollectionModalOpen(true)}
            className="px-3.5 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-xl text-xs font-bold flex items-center gap-1.5 shadow-xs transition"
          >
            <ClipboardList size={15} /> + Record Item Collection
          </button>

          <button
            onClick={loadInventory}
            disabled={loading}
            className="p-2 bg-zinc-100 hover:bg-zinc-200 dark:bg-zinc-800 dark:hover:bg-zinc-700 text-zinc-700 dark:text-zinc-300 rounded-xl text-xs font-bold transition"
            title="Refresh Inventory"
          >
            <RefreshCw size={14} className={loading ? 'animate-spin' : ''} />
          </button>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 lg:gap-4">
        <div className="p-4 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-2xl shadow-xs">
          <div className="flex items-center justify-between">
            <span className="text-xs font-bold text-zinc-500">Active SKUs</span>
            <div className="p-2 rounded-xl bg-orange-500/10 text-orange-600"><Package size={16} /></div>
          </div>
          <div className="text-2xl font-black text-zinc-900 dark:text-zinc-100 mt-2">{summary.totalSKUs || products.length}</div>
          <span className="text-[11px] text-zinc-400 mt-0.5 block">Catalog products</span>
        </div>

        <div className="p-4 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-2xl shadow-xs">
          <div className="flex items-center justify-between">
            <span className="text-xs font-bold text-zinc-500">Units in Stock</span>
            <div className="p-2 rounded-xl bg-blue-500/10 text-blue-600"><Boxes size={16} /></div>
          </div>
          <div className="text-2xl font-black text-zinc-900 dark:text-zinc-100 mt-2">{summary.totalQuantity.toLocaleString()}</div>
          <span className="text-[11px] text-zinc-400 mt-0.5 block">Total cartons & bags</span>
        </div>

        <div className="p-4 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-2xl shadow-xs">
          <div className="flex items-center justify-between">
            <span className="text-xs font-bold text-zinc-500">Total Valuation</span>
            <div className="p-2 rounded-xl bg-emerald-500/10 text-emerald-600"><Boxes size={16} /></div>
          </div>
          <div className="text-2xl font-black text-zinc-900 dark:text-zinc-100 mt-2">₦{(summary.totalValuation || 0).toLocaleString()}</div>
          <span className="text-[11px] text-zinc-400 mt-0.5 block">At cost basis</span>
        </div>

        <div className="p-4 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-2xl shadow-xs">
          <div className="flex items-center justify-between">
            <span className="text-xs font-bold text-zinc-500">Low Stock Alerts</span>
            <div className="p-2 rounded-xl bg-rose-500/10 text-rose-600"><AlertTriangle size={16} /></div>
          </div>
          <div className="text-2xl font-black text-rose-600 dark:text-rose-400 mt-2">{summary.lowStockCount}</div>
          <span className="text-[11px] text-rose-500 mt-0.5 block">Below reorder trigger</span>
        </div>
      </div>

      {/* Tabs Navigation */}
      <div className="flex items-center gap-2 border-b border-zinc-200 dark:border-zinc-800 pb-2 text-xs font-bold overflow-x-auto">
        <button
          onClick={() => setActiveTab('stock')}
          className={`px-4 py-2 rounded-xl whitespace-nowrap transition ${
            activeTab === 'stock'
              ? 'bg-orange-500 text-white shadow-xs'
              : 'bg-zinc-100 dark:bg-zinc-800 text-zinc-600 dark:text-zinc-400 hover:bg-zinc-200'
          }`}
        >
          Stock Catalog ({filteredProducts.length})
        </button>

        <button
          onClick={() => setActiveTab('movements')}
          className={`px-4 py-2 rounded-xl whitespace-nowrap transition ${
            activeTab === 'movements'
              ? 'bg-orange-500 text-white shadow-xs'
              : 'bg-zinc-100 dark:bg-zinc-800 text-zinc-600 dark:text-zinc-400 hover:bg-zinc-200'
          }`}
        >
          Movement History ({movements.length})
        </button>

        <button
          onClick={() => setActiveTab('warehouses')}
          className={`px-4 py-2 rounded-xl whitespace-nowrap transition ${
            activeTab === 'warehouses'
              ? 'bg-orange-500 text-white shadow-xs'
              : 'bg-zinc-100 dark:bg-zinc-800 text-zinc-600 dark:text-zinc-400 hover:bg-zinc-200'
          }`}
        >
          Warehouses & Hubs ({warehouses.length})
        </button>

        <button
          onClick={() => setActiveTab('collected')}
          className={`px-4 py-2 rounded-xl whitespace-nowrap transition flex items-center gap-1.5 ${
            activeTab === 'collected'
              ? 'bg-blue-600 text-white shadow-xs'
              : 'bg-zinc-100 dark:bg-zinc-800 text-zinc-600 dark:text-zinc-400 hover:bg-zinc-200'
          }`}
        >
          <ClipboardList size={13} />
          <span>Collected & Dispatched Items ({collectedMovements.length})</span>
        </button>
      </div>

      {/* Tab 1: Stock Catalog */}
      {activeTab === 'stock' && (
        <div className="space-y-4">
          {/* Filters Bar */}
          <div className="flex flex-wrap items-center justify-between gap-3 p-3 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-2xl">
            <div className="flex flex-wrap items-center gap-2 flex-1">
              <div className="relative min-w-[220px]">
                <Search size={15} className="absolute left-3 top-2.5 text-zinc-400" />
                <input
                  type="text"
                  value={search}
                  onChange={(e) => setSearch(e.target.value)}
                  placeholder="Search SKU or product..."
                  className="w-full pl-9 pr-3 py-1.5 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl text-xs outline-none"
                />
              </div>

              <select
                value={categoryFilter}
                onChange={(e) => setCategoryFilter(e.target.value)}
                className="px-3 py-1.5 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl text-xs font-semibold text-zinc-700 dark:text-zinc-300"
              >
                {categories.map(c => (
                  <option key={c} value={c}>{c === 'all' ? 'All Categories' : c}</option>
                ))}
              </select>

              <button
                onClick={() => setLowStockOnly(!lowStockOnly)}
                className={`px-3 py-1.5 rounded-xl text-xs font-bold border transition ${
                  lowStockOnly
                    ? 'bg-rose-500/10 text-rose-600 border-rose-500/30'
                    : 'bg-zinc-50 dark:bg-zinc-800 text-zinc-600 dark:text-zinc-400 border-zinc-200 dark:border-zinc-700'
                }`}
              >
                ⚠️ Low Stock Only
              </button>
            </div>

            <button
              onClick={() => setAddProductModalOpen(true)}
              className="px-3.5 py-1.5 bg-orange-500/10 hover:bg-orange-500/20 text-orange-600 dark:text-orange-400 border border-orange-500/30 rounded-xl text-xs font-bold flex items-center gap-1.5 transition"
            >
              <Plus size={13} /> Add Product SKU
            </button>
          </div>

          {/* Products Table */}
          <div className="bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-2xl overflow-hidden shadow-xs">
            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs">
                <thead className="bg-zinc-50 dark:bg-zinc-950 text-zinc-500 border-b border-zinc-200 dark:border-zinc-800">
                  <tr>
                    <th className="py-3 px-4 font-bold">SKU Code</th>
                    <th className="py-3 px-4 font-bold">Product Name</th>
                    <th className="py-3 px-4 font-bold">Category</th>
                    <th className="py-3 px-4 font-bold">Warehouse Name</th>
                    <th className="py-3 px-4 font-bold">Shelve Location</th>
                    <th className="py-3 px-4 font-bold">Unit Price</th>
                    <th className="py-3 px-4 font-bold">Available Stock</th>
                    <th className="py-3 px-4 font-bold">Reorder Level</th>
                    <th className="py-3 px-4 font-bold text-right">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-zinc-100 dark:divide-zinc-800">
                  {filteredProducts.length === 0 ? (
                    <tr>
                      <td colSpan={9} className="text-center py-10 text-zinc-400 text-xs">
                        No products match the selected filters.
                      </td>
                    </tr>
                  ) : (
                    filteredProducts.map((p) => {
                      const isLow = p.stock_quantity <= (p.reorder_level || 20);
                      return (
                        <tr key={p.id} className="hover:bg-zinc-50/50 dark:hover:bg-zinc-800/40">
                          <td className="py-3.5 px-4 font-mono font-bold text-zinc-600 dark:text-zinc-400">{p.sku}</td>
                          <td className="py-3.5 px-4 font-bold text-zinc-900 dark:text-zinc-100">{p.name}</td>
                          <td className="py-3.5 px-4 text-zinc-500">{p.category}</td>
                          <td className="py-3.5 px-4 font-semibold text-zinc-700 dark:text-zinc-300">
                            {p.warehouse_name || 'Ikeja Central Depot'}
                          </td>
                          <td className="py-3.5 px-4">
                            <div className="flex items-center gap-1.5">
                              <span className="px-2 py-0.5 rounded bg-zinc-100 dark:bg-zinc-800 text-zinc-700 dark:text-zinc-300 font-mono text-[11px] font-bold border border-zinc-200 dark:border-zinc-700">
                                {p.shelve_location || 'Aisle 1 - Bay A'}
                              </span>
                              <button
                                type="button"
                                onClick={() => {
                                  setEditingProduct(p);
                                  setShelfLocationInput(p.shelve_location || '');
                                  setShelfModalOpen(true);
                                }}
                                title="Edit Shelve Location"
                                className="p-1 rounded-md text-zinc-400 hover:text-orange-500 hover:bg-orange-500/10 transition"
                              >
                                <Edit3 size={13} />
                              </button>
                            </div>
                          </td>
                          <td className="py-3.5 px-4 font-bold text-zinc-900 dark:text-zinc-100">₦{Number(p.price).toLocaleString()}</td>
                          <td className="py-3.5 px-4">
                            <span className={`px-2 py-1 rounded-lg font-bold text-xs ${
                              isLow
                                ? 'bg-rose-500/10 text-rose-600 dark:text-rose-400 border border-rose-500/20 animate-pulse'
                                : 'bg-emerald-500/10 text-emerald-600 dark:text-emerald-400'
                            }`}>
                              {p.stock_quantity} {p.unit}s {isLow ? '⚠️' : ''}
                            </span>
                          </td>
                          <td className="py-3.5 px-4 text-zinc-400">{p.reorder_level || 20} {p.unit}s</td>
                          <td className="py-3.5 px-4 text-right">
                            <button
                              onClick={() => {
                                setSelectedProduct(p);
                                setMovementModalOpen(true);
                              }}
                              className="px-2.5 py-1 bg-orange-500/10 hover:bg-orange-500/20 text-orange-600 dark:text-orange-400 rounded-lg font-bold text-[11px] transition"
                            >
                              + Restock / Move
                            </button>
                          </td>
                        </tr>
                      );
                    })
                  )}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}

      {/* Tab 2: Movements */}
      {activeTab === 'movements' && (
        <div className="bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-2xl overflow-hidden shadow-xs">
          <div className="overflow-x-auto">
            <table className="w-full text-left text-xs">
              <thead className="bg-zinc-50 dark:bg-zinc-950 text-zinc-500 border-b border-zinc-200 dark:border-zinc-800">
                <tr>
                  <th className="py-3 px-4 font-bold">Reference</th>
                  <th className="py-3 px-4 font-bold">Type</th>
                  <th className="py-3 px-4 font-bold">Product</th>
                  <th className="py-3 px-4 font-bold">Quantity</th>
                  <th className="py-3 px-4 font-bold">Previous &rarr; New</th>
                  <th className="py-3 px-4 font-bold">Notes</th>
                  <th className="py-3 px-4 font-bold">Date</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-zinc-100 dark:divide-zinc-800">
                {movements.map((m) => (
                  <tr key={m.id} className="hover:bg-zinc-50/50 dark:hover:bg-zinc-800/40">
                    <td className="py-3.5 px-4 font-mono font-bold text-zinc-600 dark:text-zinc-400">{m.reference_number}</td>
                    <td className="py-3.5 px-4">
                      <span className={`px-2 py-0.5 rounded text-[10px] font-bold uppercase ${
                        m.movement_type === 'RESTOCK'
                          ? 'bg-emerald-500/10 text-emerald-600'
                          : m.movement_type === 'DISPATCH'
                          ? 'bg-blue-500/10 text-blue-600'
                          : 'bg-amber-500/10 text-amber-600'
                      }`}>
                        {m.movement_type}
                      </span>
                    </td>
                    <td className="py-3.5 px-4 font-bold text-zinc-900 dark:text-zinc-100">{m.product?.name || `Product #${m.product_id}`}</td>
                    <td className="py-3.5 px-4 font-bold text-zinc-800 dark:text-zinc-200">
                      {m.movement_type === 'RESTOCK' ? '+' : '-'}{m.quantity}
                    </td>
                    <td className="py-3.5 px-4 text-zinc-500">{m.previous_quantity} &rarr; <span className="font-bold text-zinc-800 dark:text-zinc-200">{m.new_quantity}</span></td>
                    <td className="py-3.5 px-4 text-zinc-400">{m.notes || '—'}</td>
                    <td className="py-3.5 px-4 text-zinc-400">{new Date(m.created_at).toLocaleString()}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Tab 3: Warehouses */}
      {activeTab === 'warehouses' && (
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          {warehouses.map((wh) => (
            <div key={wh.id} className="p-5 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-2xl space-y-3 shadow-xs">
              <div className="flex items-center justify-between">
                <div className="p-2.5 rounded-xl bg-orange-500/10 text-orange-600"><Warehouse size={20} /></div>
                <span className="text-xs font-mono font-bold text-zinc-400">{wh.code}</span>
              </div>
              <div>
                <h3 className="font-bold text-zinc-900 dark:text-zinc-100 text-sm">{wh.name}</h3>
                <p className="text-xs text-zinc-400 mt-0.5">{wh.address}</p>
              </div>
              <div className="pt-2 border-t border-zinc-100 dark:border-zinc-800 flex items-center justify-between text-xs text-zinc-500">
                <span>Status</span>
                <span className="text-emerald-600 font-bold flex items-center gap-1">
                  <CheckCircle2 size={12} /> Operational
                </span>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Tab 4: Collected & Dispatched Items (NEW) */}
      {activeTab === 'collected' && (
        <div className="space-y-4">
          <div className="flex items-center justify-between p-4 rounded-2xl bg-blue-500/10 border border-blue-500/20 text-blue-700 dark:text-blue-300">
            <div className="flex items-center gap-2.5 text-xs font-bold">
              <ClipboardList size={18} />
              <span>Log of items picked up or collected by drivers, sales reps, and customer reps.</span>
            </div>
            <button
              type="button"
              onClick={() => setCollectionModalOpen(true)}
              className="px-3.5 py-1.5 bg-blue-600 hover:bg-blue-700 text-white rounded-xl text-xs font-bold flex items-center gap-1.5 shadow-xs transition"
            >
              <Plus size={13} /> + Record Collection
            </button>
          </div>

          <div className="bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-2xl overflow-hidden shadow-xs">
            <div className="overflow-x-auto">
              <table className="w-full text-left text-xs">
                <thead className="bg-zinc-50 dark:bg-zinc-950 text-zinc-500 border-b border-zinc-200 dark:border-zinc-800">
                  <tr>
                    <th className="py-3 px-4 font-bold">Waybill / Ref</th>
                    <th className="py-3 px-4 font-bold">Product Item</th>
                    <th className="py-3 px-4 font-bold">Qty Released</th>
                    <th className="py-3 px-4 font-bold">Collection Details & Collector</th>
                    <th className="py-3 px-4 font-bold">Timestamp</th>
                    <th className="py-3 px-4 font-bold">Status</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-zinc-100 dark:divide-zinc-800">
                  {collectedMovements.length === 0 ? (
                    <tr>
                      <td colSpan={6} className="text-center py-10 text-zinc-400 text-xs italic">
                        No collected items logged yet. Click "+ Record Item Collection" to sign out items when someone picks them up.
                      </td>
                    </tr>
                  ) : (
                    collectedMovements.map((m) => {
                      const prod = products.find(p => p.id === m.product_id);
                      return (
                        <tr key={m.id} className="hover:bg-zinc-50/50 dark:hover:bg-zinc-800/40">
                          <td className="py-3.5 px-4 font-mono font-bold text-blue-600 dark:text-blue-400">{m.reference_number}</td>
                          <td className="py-3.5 px-4 font-bold text-zinc-900 dark:text-zinc-100">
                            {prod?.name || m.product?.name || `Product #${m.product_id}`}
                          </td>
                          <td className="py-3.5 px-4 font-bold text-zinc-900 dark:text-zinc-100">
                            <span className="px-2 py-0.5 rounded bg-blue-500/10 text-blue-600 font-bold">
                              {m.quantity} {prod?.unit || 'units'}
                            </span>
                          </td>
                          <td className="py-3.5 px-4 text-zinc-600 dark:text-zinc-300">
                            {m.notes || 'Direct Depot Pick-up'}
                          </td>
                          <td className="py-3.5 px-4 text-zinc-400 font-mono text-[11px]">
                            {new Date(m.created_at).toLocaleString()}
                          </td>
                          <td className="py-3.5 px-4">
                            <span className="px-2 py-0.5 rounded bg-emerald-500/10 text-emerald-600 font-bold text-[10px] uppercase flex items-center gap-1 w-max">
                              <CheckCircle2 size={11} /> Dispatched & Signed Out
                            </span>
                          </td>
                        </tr>
                      );
                    })
                  )}
                </tbody>
              </table>
            </div>
          </div>
        </div>
      )}

      {/* MODAL 1: ADD NEW ITEM / PRODUCT */}
      {addProductModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs animate-in fade-in">
          <div className="w-full max-w-lg bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-3xl shadow-2xl overflow-hidden">
            <div className="p-5 border-b border-zinc-100 dark:border-zinc-800 flex items-center justify-between bg-gradient-to-r from-orange-500/10 to-transparent">
              <div>
                <h3 className="font-black text-zinc-900 dark:text-zinc-100 text-base flex items-center gap-2">
                  <Package size={18} className="text-orange-500" />
                  <span>Add New Item / Product SKU</span>
                </h3>
                <p className="text-xs text-zinc-400">Add a new SKU to the central inventory catalog & warehouse</p>
              </div>
              <button onClick={() => setAddProductModalOpen(false)} className="p-1.5 text-zinc-400 hover:text-zinc-600 dark:hover:text-zinc-200 rounded-lg">
                <X size={18} />
              </button>
            </div>

            <form onSubmit={handleCreateProduct} className="p-6 space-y-4 text-xs">
              <div className="space-y-1">
                <label className="font-bold text-zinc-700 dark:text-zinc-300">Product Name *</label>
                <input
                  type="text"
                  required
                  value={productForm.name}
                  onChange={(e) => setProductForm({ ...productForm, name: e.target.value })}
                  placeholder="e.g. Indomie Instant Noodles 70g (Carton 40pcs)"
                  className="w-full px-3.5 py-2.5 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl font-bold"
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">SKU Code</label>
                  <input
                    type="text"
                    value={productForm.sku}
                    onChange={(e) => setProductForm({ ...productForm, sku: e.target.value })}
                    placeholder="Auto-generated or custom SKU"
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl font-mono"
                  />
                </div>
                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">Category</label>
                  <input
                    type="text"
                    value={productForm.category}
                    onChange={(e) => setProductForm({ ...productForm, category: e.target.value })}
                    placeholder="e.g. Packaged Food, Beverages"
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl"
                  />
                </div>
              </div>

              <div className="grid grid-cols-3 gap-3">
                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">Unit Price (₦) *</label>
                  <input
                    type="number"
                    required
                    min="0"
                    value={productForm.price}
                    onChange={(e) => setProductForm({ ...productForm, price: e.target.value })}
                    placeholder="8500"
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl font-bold"
                  />
                </div>
                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">Initial Stock</label>
                  <input
                    type="number"
                    min="0"
                    value={productForm.stock_quantity}
                    onChange={(e) => setProductForm({ ...productForm, stock_quantity: Number(e.target.value) })}
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl"
                  />
                </div>
                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">Reorder Level</label>
                  <input
                    type="number"
                    min="1"
                    value={productForm.reorder_level}
                    onChange={(e) => setProductForm({ ...productForm, reorder_level: Number(e.target.value) })}
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">Fulfillment Warehouse</label>
                  <select
                    value={productForm.warehouse_name}
                    onChange={(e) => setProductForm({ ...productForm, warehouse_name: e.target.value })}
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl"
                  >
                    {warehouses.map(w => (
                      <option key={w.id} value={w.name}>{w.name}</option>
                    ))}
                    {warehouses.length === 0 && (
                      <option value="Ikeja Central Depot">Ikeja Central Depot</option>
                    )}
                  </select>
                </div>

                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">Shelve Location</label>
                  <input
                    type="text"
                    value={productForm.shelve_location}
                    onChange={(e) => setProductForm({ ...productForm, shelve_location: e.target.value })}
                    placeholder="e.g. Aisle 3 - Bay C (Rack 2)"
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl"
                  />
                </div>
              </div>

              <div className="pt-3 flex items-center justify-end gap-2 border-t border-zinc-100 dark:border-zinc-800">
                <button
                  type="button"
                  onClick={() => setAddProductModalOpen(false)}
                  className="px-4 py-2 bg-zinc-100 dark:bg-zinc-800 rounded-xl font-bold text-zinc-600 dark:text-zinc-300"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={submittingProduct}
                  className="px-5 py-2 bg-orange-500 hover:bg-orange-600 text-white rounded-xl font-bold shadow-xs transition"
                >
                  {submittingProduct ? 'Saving...' : 'Add Item to Catalog'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* MODAL 2: EDIT SHELVE LOCATION */}
      {shelfModalOpen && editingProduct && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs animate-in fade-in">
          <div className="w-full max-w-md bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-3xl shadow-2xl overflow-hidden">
            <div className="p-5 border-b border-zinc-100 dark:border-zinc-800 flex items-center justify-between">
              <div>
                <h3 className="font-black text-zinc-900 dark:text-zinc-100 text-sm flex items-center gap-2">
                  <Edit3 size={16} className="text-orange-500" />
                  <span>Edit Shelve Location</span>
                </h3>
                <p className="text-xs text-zinc-400">{editingProduct.name}</p>
              </div>
              <button onClick={() => setShelfModalOpen(false)} className="p-1.5 text-zinc-400 hover:text-zinc-600 rounded-lg">
                <X size={16} />
              </button>
            </div>

            <form onSubmit={handleSaveShelfLocation} className="p-5 space-y-4 text-xs">
              <div className="space-y-1">
                <label className="font-bold text-zinc-700 dark:text-zinc-300">
                  New Shelve / Bay Location *
                </label>
                <input
                  type="text"
                  required
                  value={shelfLocationInput}
                  onChange={(e) => setShelfLocationInput(e.target.value)}
                  placeholder="e.g. Aisle 2 - Bay B (Rack 4, Bin 12)"
                  className="w-full px-3.5 py-2.5 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl font-bold"
                />
              </div>

              <div className="pt-2 flex items-center justify-end gap-2 border-t border-zinc-100 dark:border-zinc-800">
                <button
                  type="button"
                  onClick={() => setShelfModalOpen(false)}
                  className="px-4 py-2 bg-zinc-100 dark:bg-zinc-800 rounded-xl font-bold text-zinc-600 dark:text-zinc-300"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={submittingShelf}
                  className="px-5 py-2 bg-orange-500 hover:bg-orange-600 text-white rounded-xl font-bold shadow-xs transition"
                >
                  {submittingShelf ? 'Updating...' : 'Save Shelve Location'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* MODAL 3: RECORD ITEM COLLECTION / SIGN-OUT */}
      {collectionModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs animate-in fade-in">
          <div className="w-full max-w-lg bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-3xl shadow-2xl overflow-hidden">
            <div className="p-5 border-b border-zinc-100 dark:border-zinc-800 flex items-center justify-between bg-gradient-to-r from-blue-500/10 to-transparent">
              <div>
                <h3 className="font-black text-zinc-900 dark:text-zinc-100 text-base flex items-center gap-2">
                  <ClipboardList size={18} className="text-blue-500" />
                  <span>Record Collected Item / Sign-Out</span>
                </h3>
                <p className="text-xs text-zinc-400">Log items released to driver, representative or customer</p>
              </div>
              <button onClick={() => setCollectionModalOpen(false)} className="p-1.5 text-zinc-400 hover:text-zinc-600 rounded-lg">
                <X size={18} />
              </button>
            </div>

            <form onSubmit={handleRecordCollection} className="p-6 space-y-3.5 text-xs">
              <div className="space-y-1">
                <label className="font-bold text-zinc-700 dark:text-zinc-300">Select Product Item *</label>
                <select
                  required
                  value={collectionForm.product_id}
                  onChange={(e) => setCollectionForm({ ...collectionForm, product_id: e.target.value })}
                  className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl font-bold"
                >
                  {products.map(p => (
                    <option key={p.id} value={p.id}>
                      {p.name} ({p.sku}) &bull; {p.stock_quantity} available
                    </option>
                  ))}
                </select>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">Quantity Collected *</label>
                  <input
                    type="number"
                    min="1"
                    required
                    value={collectionForm.quantity}
                    onChange={(e) => setCollectionForm({ ...collectionForm, quantity: Number(e.target.value) })}
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl font-bold"
                  />
                </div>
                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">Fulfillment Depot</label>
                  <select
                    value={collectionForm.warehouse_id}
                    onChange={(e) => setCollectionForm({ ...collectionForm, warehouse_id: Number(e.target.value) })}
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl"
                  >
                    {warehouses.map(w => (
                      <option key={w.id} value={w.id}>{w.name}</option>
                    ))}
                  </select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">Collector's Full Name *</label>
                  <input
                    type="text"
                    required
                    value={collectionForm.collector_name}
                    onChange={(e) => setCollectionForm({ ...collectionForm, collector_name: e.target.value })}
                    placeholder="e.g. Babatunde Lawal (Driver)"
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl font-bold"
                  />
                </div>
                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">Collector's Phone / ID</label>
                  <input
                    type="text"
                    value={collectionForm.collector_phone}
                    onChange={(e) => setCollectionForm({ ...collectionForm, collector_phone: e.target.value })}
                    placeholder="+2348012345678"
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">Department / Destination</label>
                  <input
                    type="text"
                    value={collectionForm.collector_department}
                    onChange={(e) => setCollectionForm({ ...collectionForm, collector_department: e.target.value })}
                    placeholder="e.g. Lekki Field Hub, Supermarket Order"
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl"
                  />
                </div>
                <div className="space-y-1">
                  <label className="font-bold text-zinc-700 dark:text-zinc-300">Waybill / Requisition #</label>
                  <input
                    type="text"
                    value={collectionForm.waybill_number}
                    onChange={(e) => setCollectionForm({ ...collectionForm, waybill_number: e.target.value })}
                    placeholder="e.g. WAYBILL-2026-092"
                    className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl font-mono"
                  />
                </div>
              </div>

              <div className="space-y-1">
                <label className="font-bold text-zinc-700 dark:text-zinc-300">Collection Purpose & Notes</label>
                <textarea
                  rows={2}
                  value={collectionForm.notes}
                  onChange={(e) => setCollectionForm({ ...collectionForm, notes: e.target.value })}
                  placeholder="e.g. Dispatched for Lekki route distribution. Signed out by warehouse supervisor."
                  className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl outline-none"
                />
              </div>

              <div className="pt-3 flex items-center justify-end gap-2 border-t border-zinc-100 dark:border-zinc-800">
                <button
                  type="button"
                  onClick={() => setCollectionModalOpen(false)}
                  className="px-4 py-2 bg-zinc-100 dark:bg-zinc-800 rounded-xl font-bold text-zinc-600 dark:text-zinc-300"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={submittingCollection}
                  className="px-5 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-xl font-bold shadow-xs transition"
                >
                  {submittingCollection ? 'Signing out...' : 'Sign Out & Release Item'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* MODAL 4: RESTOCK / STOCK MOVEMENT */}
      {movementModalOpen && selectedProduct && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-xs">
          <div className="w-full max-w-md bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-2xl shadow-2xl overflow-hidden">
            <div className="p-4 border-b border-zinc-100 dark:border-zinc-800 flex items-center justify-between">
              <div>
                <h3 className="font-black text-zinc-900 dark:text-zinc-100 text-sm">Stock Movement & Restock</h3>
                <p className="text-xs text-zinc-400">{selectedProduct.name}</p>
              </div>
              <button onClick={() => setMovementModalOpen(false)} className="p-1 text-zinc-400 hover:text-zinc-600 rounded">
                <X size={16} />
              </button>
            </div>

            <form onSubmit={handleRecordMovement} className="p-5 space-y-3.5 text-xs">
              <div>
                <label className="font-semibold text-zinc-700 dark:text-zinc-300 block mb-1">Movement Type</label>
                <select
                  value={movementForm.movement_type}
                  onChange={(e) => setMovementForm({ ...movementForm, movement_type: e.target.value })}
                  className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl"
                >
                  <option value="RESTOCK">RESTOCK (+ Add Factory Stock)</option>
                  <option value="DISPATCH">DISPATCH (- Outlet Delivery)</option>
                  <option value="TRANSFER">TRANSFER (Depot Rebalance)</option>
                  <option value="DAMAGE">DAMAGE (- Write Off)</option>
                </select>
              </div>

              <div>
                <label className="font-semibold text-zinc-700 dark:text-zinc-300 block mb-1">Fulfillment Warehouse</label>
                <select
                  value={movementForm.warehouse_id}
                  onChange={(e) => setMovementForm({ ...movementForm, warehouse_id: Number(e.target.value) })}
                  className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl"
                >
                  {warehouses.map(w => (
                    <option key={w.id} value={w.id}>{w.name}</option>
                  ))}
                </select>
              </div>

              <div>
                <label className="font-semibold text-zinc-700 dark:text-zinc-300 block mb-1">Quantity ({selectedProduct.unit}s)</label>
                <input
                  type="number"
                  min="1"
                  required
                  value={movementForm.quantity}
                  onChange={(e) => setMovementForm({ ...movementForm, quantity: Number(e.target.value) })}
                  className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl font-bold"
                />
              </div>

              <div>
                <label className="font-semibold text-zinc-700 dark:text-zinc-300 block mb-1">Reference PO / Invoice No.</label>
                <input
                  type="text"
                  value={movementForm.reference_number}
                  onChange={(e) => setMovementForm({ ...movementForm, reference_number: e.target.value })}
                  placeholder="e.g. PO-2026-AUG-88"
                  className="w-full px-3 py-2 bg-zinc-50 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-700 rounded-xl"
                />
              </div>

              <div className="pt-2 flex items-center justify-end gap-2">
                <button
                  type="button"
                  onClick={() => setMovementModalOpen(false)}
                  className="px-4 py-2 bg-zinc-100 dark:bg-zinc-800 rounded-xl font-bold text-zinc-600 dark:text-zinc-300"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={submittingMovement}
                  className="px-5 py-2 bg-orange-500 hover:bg-orange-600 text-white rounded-xl font-bold shadow-xs transition"
                >
                  {submittingMovement ? 'Saving...' : 'Confirm Movement'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}

