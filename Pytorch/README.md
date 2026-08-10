# 🍔 Ottimizzazione di una rete neurale per la classificazione di immagini di cibo

Progetto per **GourmetAI Inc.**: sviluppo e confronto di modelli di deep learning per la classificazione di immagini
di cibo in 14 categorie, tramite tecniche di data augmentation, transfer learning, validation e regolarizzazione.

## Struttura del progetto

```
├── dataset/                     # Dataset Food Classification (train / val / test)
│   ├── train/
│   ├── val/
│   └── test/
├── models/                      # Checkpoint (.pt) e log di training (.json) per ciascun modello
│   ├── vgg/
│   │   ├── model.pt             # Pesi del checkpoint con validation loss minima
│   │   └── log.json             # Storico di train_losses / test_losses / test_accuracies
│   └── resnet/
│       ├── model.pt
│       └── log.json
├── NN optimization.ipynb        # Notebook principale: dataset, training, confronto, test finale
├── requirements.txt
└── README.md
```

> **Nota:** il dataset e i modelli addestrati non sono inclusi nel repository (troppo pesanti). Scarica il dataset
> dal link indicato nel notebook ed estrailo nella cartella `dataset/` prima di eseguire le celle.

## Pipeline

1. **Data Augmentation**: rotazioni di 90°, flip orizzontale/verticale, shear/scale affine random, applicate solo
   al train set. Val e test set usano solo resize + normalizzazione, per una valutazione non distorta.
2. **Dataset split**: train / val / test già separati in cartelle distinte (`ImageFolder`), 14 classi bilanciate
   (640 immagini/classe nel train set).
3. **Architetture (Transfer Learning)**: backbone pre-addestrati su ImageNet, **congelati**, con classificatore
   custom (`AdaptiveAvgPool2d` + `Linear`) allenato da zero:
   - **VGG19**
   - **ResNet152**
4. **Training**: `Adam`, `CrossEntropyLoss`, early stopping su validation loss (patience=5), progress bar `tqdm`.
5. **Confronto modelli**: grafici di train/validation loss e validation accuracy per epoca, riepilogo numerico
   della miglior epoca per modello.
6. **Test finale**: valutazione del modello con la miglior validation accuracy (**ResNet152**) sul test set,
   con confusion matrix normalizzata e classification report per classe.

## Risultati (validation, miglior epoca)

| Modello       | Val Loss | Val Accuracy |
|---------------|----------|--------------|
| VGG19         | ~0.644   | ~0.80        |
| **ResNet152** | ~0.446   | **~0.86**    |

ResNet152 è stato selezionato come modello finale e valutato sul test set (vedi notebook per i risultati
aggiornati, incluso classification report per classe).

