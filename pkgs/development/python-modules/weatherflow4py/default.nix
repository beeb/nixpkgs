{
  lib,
  aiohttp,
  aioresponses,
  buildPythonPackage,
  dataclasses-json,
  fetchFromGitHub,
  marshmallow,
  poetry-core,
  pytest-asyncio,
  pytestCheckHook,
  pythonOlder,
  websockets,
}:

buildPythonPackage rec {
  pname = "weatherflow4py";
  version = "1.3.1";
  pyproject = true;

  disabled = pythonOlder "3.12";

  src = fetchFromGitHub {
    owner = "jeeftor";
    repo = "weatherflow4py";
    tag = "v${version}";
    hash = "sha256-X5zMxX8PthiqaEIM0/fElGIjeeCey0ossVDKevy1Mnw=";
  };

  build-system = [ poetry-core ];

  dependencies = [
    aiohttp
    dataclasses-json
    marshmallow
    websockets
  ];

  nativeCheckInputs = [
    aioresponses
    pytest-asyncio
    pytestCheckHook
  ];

  pythonImportsCheck = [ "weatherflow4py" ];

  disabledTests = [
    # KeyError
    "test_convert_json_to_weather_data4"
  ];

  meta = with lib; {
    description = "Module to interact with the WeatherFlow REST API";
    homepage = "https://github.com/jeeftor/weatherflow4py";
    changelog = "https://github.com/jeeftor/weatherflow4py/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
