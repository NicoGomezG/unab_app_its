import 'package:flutter/material.dart';
import 'package:unab_app_its/Model/curso_model.dart';

class CursoItem extends StatelessWidget {
  final CursoModel? model;
  final Function? onDelete;

  CursoItem({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: cartItem(context),
      ),
    );
  }

  Widget cartItem(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          child: Image.network(
            (model!.cursoImage == null || model!.cursoImage == "")
                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                : model!.cursoImage!,
            height: 70,
            fit: BoxFit.scaleDown,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model!.cursoName!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${model!.cursoNrc}",
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.edit),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/edit-curso',
                          arguments: {
                            'model': model,
                          },
                        );
                      },
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        onDelete!(model);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
