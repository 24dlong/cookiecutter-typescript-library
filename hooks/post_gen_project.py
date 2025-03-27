import json
from collections import OrderedDict

scope = "{{ cookiecutter.scope }}"
project_slug = "{{ cookiecutter.project_slug }}"

package_json_path = "package.json"

with open(package_json_path, "r") as f:
    package_data = json.load(f)

# Create a new OrderedDict with "name" at the top
ordered_package_data = OrderedDict()
ordered_package_data["name"] = f"{scope}{'/' if scope else ''}{project_slug}"
ordered_package_data.update(package_data)  # Preserve existing keys in order

with open(package_json_path, "w") as f:
    json.dump(ordered_package_data, f, indent=2)
