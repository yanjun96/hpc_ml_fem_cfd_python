import os
import ast

def find_imported_modules(directory):
    imported_modules = set()
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".py"):
                with open(os.path.join(root, file), "r", encoding="utf-8") as f:
                    tree = ast.parse(f.read(), filename=file)
                    for node in ast.walk(tree):
                        if isinstance(node, ast.Import):
                            for alias in node.names:
                                imported_modules.add(alias.name)
                        elif isinstance(node, ast.ImportFrom):
                            imported_modules.add(node.module)
    return sorted(imported_modules)

project_dir = "/path/to/your/project"
modules = find_imported_modules(project_dir)
print("Imported modules:", modules)
