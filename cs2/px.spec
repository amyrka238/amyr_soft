# -*- mode: python ; coding: utf-8 -*-

import os
import site

# Пути к бинарным файлам
binaries = []
for path in site.getsitepackages():
    glfw_path = os.path.join(path, 'glfw')
    if os.path.exists(glfw_path):
        for file in os.listdir(glfw_path):
            if file.endswith('.dll'):
                binaries.append((os.path.join(glfw_path, file), 'glfw'))
    opengl_path = os.path.join(path, 'PyOpenGL', 'DLLs')
    if os.path.exists(opengl_path):
        for file in os.listdir(opengl_path):
            if file.endswith('.dll'):
                binaries.append((os.path.join(opengl_path, file), 'PyOpenGL/DLLs'))
    pymem_path = os.path.join(path, 'pymem')
    if os.path.exists(pymem_path):
        for file in os.listdir(pymem_path):
            if file.endswith('.dll'):
                binaries.append((os.path.join(pymem_path, file), 'pymem'))

a = Analysis(
    ['px.py'],
    pathex=[],
    binaries=binaries,
    datas=[('C:\\Users\\melod\\Downloads\\Telegram Desktop\\PyIt---external-cheat-cs2-in-python-main\\.vs\\ProjectSettings.json', '.vs'), ('C:\\Users\\melod\\Downloads\\Telegram Desktop\\PyIt---external-cheat-cs2-in-python-main\\.vs\\PythonSettings.json', '.vs'), ('C:\\Users\\melod\\Downloads\\Telegram Desktop\\PyIt---external-cheat-cs2-in-python-main\\.vs\\VSWorkspaceState.json', '.vs')],
    hiddenimports=['pymem', 'imgui', 'glfw', 'OpenGL.GL', 'imgui.integrations.glfw', 'PIL.ImageGrab', 'scipy.signal', 'multiprocessing', 'multiprocessing.Manager', 'struct', 'win32api', 'win32con', 'win32gui'],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='px',
    debug=True,  # Оставим отладку
    bootloader_ignore_signals=False,
    strip=False,
    upx=False,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon=['1.ico'],
)