import os
import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt


DB_CONFIG = {
    'host': 'localhost',
    'user': 'campus2023',
    'password': 'gaseosas_10',
    'database': 'gaseosas_del_valle'
}

def generate_reports():
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        print(" Connected to MySQL successfully.")

        excel_path = "reporte_ventas_gaseosas.xlsx"
        with pd.ExcelWriter(excel_path, engine='openpyxl') as writer:
            df_sedes = pd.read_sql("SELECT * FROM vista_resumen_pedidos_por_sede;", conn)
            df_sedes.to_excel(writer, sheet_name='Ventas por Sede', index=False)

            df_bajo_stock = pd.read_sql("SELECT * FROM vista_productos_bajo_stock;", conn)
            df_bajo_stock.to_excel(writer, sheet_name='Bajo Stock', index=False)

            df_pedidos = pd.read_sql("SELECT * FROM pedidos;", conn)
            df_pedidos.to_excel(writer, sheet_name='Historial Pedidos', index=False)
            
        print(f" Excel Report generated: {excel_path}")

        df_grafica = pd.read_sql("SELECT nombre_sede, total_ventas_con_iva FROM vista_resumen_pedidos_por_sede;", conn)
        
        plt.figure(figsize=(8, 5))
        plt.bar(df_grafica['nombre_sede'], df_grafica['total_ventas_con_iva'], color='#2b5c8f')
        plt.title('Ventas Totales por Sede (COP) - Gaseosas del Valle S.A.')
        plt.xlabel('Sede')
        plt.ylabel('Ventas ($)')
        plt.grid(axis='y', linestyle='--', alpha=0.7)
        plt.tight_layout()
        
        chart_path = "grafica_ventas_sedes.png"
        plt.savefig(chart_path)
        print(f" Chart generated: {chart_path}")

        conn.close()
    except Exception as e:
        print(f" Error: {e}")

if __name__ == "__main__":
    generate_reports()