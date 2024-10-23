import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zezis_widget/data/country_model.dart';
import 'package:zezis_widget/z_button/z_button.dart';
import 'package:zezis_widget/zezis_widget.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  PaisModel? country;
  var loadingCustom = false;
  var loadingSimple = false;
  FocusNode focus = FocusNode();
  var phone = TextEditingController();
  
  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Input"),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),

            child: Column(
              children: [
                FocusTraversalOrder(
                  order: const NumericFocusOrder(1.0),

                  child: ZComboBox(
                    labelText: "Pais ",
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    contentPadding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                  
                    value: country,
                    items: countries.map((x) {
                      return DropdownMenuItem<PaisModel>(
                        value: x,
                        child: Text(
                          x.descricao,
                          style: GoogleFonts.roboto(color: Colors.black),
                        ),
                      );
                    }).toList(),
                      
                    onChanged: (value) {
                      phone.text = value?.mascaraCelular ?? "";
                      setState(() => country = value ?? countries.first);
                    },
                  ),
                ),
            
                FocusTraversalOrder(
                  order: const NumericFocusOrder(2.0),
                  
                  child: ZTextFormFieldPhone(
                    orderDdi: 2.0,
                    orderContact: 3.0,
                    enableIcon: false,    
                    
                    countries: countries,
                    textFieldController: phone, 
                    country: country ?? countries.first, 
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    
                    onChanged: (value) {},
                    onInputChanged: (value) {}, 
                  ),
                ),
            
                FocusTraversalOrder(
                  order: const NumericFocusOrder(4.0),
                  
                  child: search(context)
                ),
            
                FocusTraversalOrder(
                  order: const NumericFocusOrder(3.0),
                  
                  child: ZTextFormField(
                    autofocus: false,
                    labelText: "Pais",
                    controller: phone,
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  ),
                ),

                ZButton(
                  label: "Next", 
                  onTap: () => FocusScope.of(context).requestFocus(focus),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  /// Search
  Widget search(BuildContext context) {
    if (country?.id != null) {
      return selectAutoComplete(  
        enable: true,   
        context: context,
        labelText: "Pais",
        title: (country?.descricao ?? "").toUpperCase(),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),

        leading: Icon(
          Icons.person_rounded,
          color: Theme.of(context).primaryColor,
        ),

        onPressed: () {
          FocusScope.of(context).requestFocus(focus);
          phone.text = "";

          setState(() => country = null);
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      
      child: Focus(
        focusNode: focus,

        child: ZHeadField<PaisModel?>(
          hideWithKeyboard: true,
          emptyBuilder: (context) => const SizedBox(),
          suggestionsCallback: (search) async => countries,
        
          builder:  (context, controller, focusNode) {
            return TextField(   
              autofocus: false,
              focusNode: focusNode,
              controller: controller,
              inputFormatters: [UpperCaseTextFormatter()],
        
              decoration: bgInputDecoration(
                context: context,
                labelText: "Pais",
        
                suffixIcon: Icon(
                  Icons.search_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                prefixIcon: Icon(
                  Icons.flag,
                  color: Theme.of(context).primaryColor,
                ),
              )
            );
          },
          
          itemBuilder: (context, PaisModel? value) {
            if (value == null) { return const SizedBox(); }
        
            return ListTile(
              title: Text(
                value.descricao.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                ),
              ),
            );
          },
        
          onSelected: (PaisModel? value) {
            phone.text = value?.mascaraCelular ?? "";
            setState(() => country = value);
          },
        ),
      ),
    );
  }
}

final List<PaisModel> countries = [
    PaisModel(
    id: 0,
    ddi: 55,
    sigla2: "BR",
    sigla3: "BRA",
    descricao: "BRASIL",
    mascaraTelefone: "00 0000-0000",
    mascaraCelular: "00 0 0000-0000",
  ),
  PaisModel(
    id: 1,
    ddi: 1,
    sigla2: "US",
    sigla3: "USA",
    descricao: "ESTADOS UNIDOS",
    mascaraTelefone: "(000) 000-0000",
    mascaraCelular: "(000) 000-0000",
  ),
  PaisModel(
    id: 2,
    ddi: 44,
    sigla2: "GB",
    sigla3: "GBR",
    descricao: "REINO UNIDO",
    mascaraTelefone: "00 0000 0000",
    mascaraCelular: "00 0000 000000",
  ),
  PaisModel(
    id: 3,
    ddi: 33,
    sigla2: "FR",
    sigla3: "FRA",
    descricao: "FRANÇA",
    mascaraTelefone: "00 00 00 00 00",
    mascaraCelular: "00 0 00 00 00 00",
  ),
  PaisModel(
    id: 4,
    ddi: 49,
    sigla2: "DE",
    sigla3: "DEU",
    descricao: "ALEMANHA",
    mascaraTelefone: "0000 000000",
    mascaraCelular: "000 000000000",
  ),
  PaisModel(
    id: 5,
    ddi: 81,
    sigla2: "JP",
    sigla3: "JPN",
    descricao: "JAPÃO",
    mascaraTelefone: "00-0000-0000",
    mascaraCelular: "00-0000-0000",
  ),
  PaisModel(
    id: 6,
    ddi: 34,
    sigla2: "ES",
    sigla3: "ESP",
    descricao: "ESPANHA",
    mascaraTelefone: "000 00 00 00",
    mascaraCelular: "000 000 000",
  ),
  PaisModel(
    id: 7,
    ddi: 39,
    sigla2: "IT",
    sigla3: "ITA",
    descricao: "ITÁLIA",
    mascaraTelefone: "00 0000 0000",
    mascaraCelular: "00 000 000000",
  ),
  PaisModel(
    id: 8,
    ddi: 7,
    sigla2: "RU",
    sigla3: "RUS",
    descricao: "RÚSSIA",
    mascaraTelefone: "000 000-00-00",
    mascaraCelular: "000 000-00-00",
  ),
  PaisModel(
    id: 9,
    ddi: 86,
    sigla2: "CN",
    sigla3: "CHN",
    descricao: "CHINA",
    mascaraTelefone: "0000-00000000",
    mascaraCelular: "0000-00000000",
  ),
];
