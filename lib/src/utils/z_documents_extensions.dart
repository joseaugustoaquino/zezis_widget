/// Formata um documento (CPF ou CNPJ) removendo caracteres não numéricos
/// e aplicando a máscara apropriada.
/// 
/// [document] - O documento a ser formatado (CPF ou CNPJ)
/// Retorna uma string formatada ou vazia se o documento for inválido
String formatDocument(String document) {
  if (document.trim().isEmpty) {
    return "";
  }

  // Remove caracteres não numéricos e espaços
  final cleanDocument = document.replaceAll(RegExp(r'[^\d]'), '').trim();
  
  // Validação básica de comprimento
  if (cleanDocument.length != 11 && cleanDocument.length != 14) {
    return document;
  }

  // Formatação baseada no tipo de documento
  if (cleanDocument.length == 11) {
    return _formatCPF(cleanDocument);
  } else {
    return _formatCNPJ(cleanDocument);
  }
}

/// Formata um CPF com a máscara XXX.XXX.XXX-XX
String _formatCPF(String cpf) {
  return "${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}";
}

/// Formata um CNPJ com a máscara XX.XXX.XXX/XXXX-XX
String _formatCNPJ(String cnpj) {
  return "${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.${cnpj.substring(5, 8)}/${cnpj.substring(8, 12)}-${cnpj.substring(12)}";
}
